class CommentsController < ApplicationController
  before_action :authenticate_user!
  def new
    @comment=Comment.new
  end

  def create
    @comment=Comment.create(comment_params)
    redirect_to request.referrer
  end

  def comment_params
    params.require(:comment).permit(:content, :author_id, :post_id)
  end
end
