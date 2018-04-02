class PostLikesController < ApplicationController
  before_action :authenticate_user!


  def new
  end

  def create
    @like=PostLike.create(post_like_params)
    redirect_to request.referrer
  end


  private

  def post_like_params
    params.require(:post_like).permit(:user_id, :post_id)
  end
end
