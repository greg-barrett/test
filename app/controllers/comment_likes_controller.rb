class CommentLikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @comment_like=CommentLike.create(comment_like_params)
    redirect_to request.referrer
  end

  private

  def comment_like_params
    params.require(:comment_like).permit(:user_id, :comment_id)
  end
end
