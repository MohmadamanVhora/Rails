class LikesController < ApplicationController
  def create
    @like = Like.new(user_id: @current_user.id, comment_id: params[:commentid])
    if @like.save
      redirect_to event_path(@like.comment.event_id)
    end
  end

  def destroy
    @like = Like.find_by(comment_id: params[:commentid])
    @like.destroy
    redirect_to event_path(@like.comment.event_id)
  end
end
