class CommentsController < ApplicationController
  before_action :find_comment, only: [:show, :edit, :update, :destroy]
 
  def index
    @comments = Comment.where(event_id: params[:eventid])
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)  
    if @comment.save
      redirect_to @comment
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy 
    redirect_to comments_path, status: :see_other
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :event_id, :user_id)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end
end
