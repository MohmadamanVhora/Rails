class CommentsController < ApplicationController
  before_action :find_comment, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :destroy]

  def new
    @comment = Comment.new
    @event = Event.find_by(id: params[:eventid])
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to event_path(@comment.event_id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to event_path(@comment.event_id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy 
    redirect_to event_path(@comment.event_id), status: :see_other
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :event_id, :user_id)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def check_user
    if @comment.user != @current_user
      flash[:alert] = "You can not edit this comment"
      redirect_to event_path(@comment.event_id)
    end
  end
end
