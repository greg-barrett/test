class PostsController < ApplicationController
  before_action :authenticate_user!
  def new
    @post=Post.new
  end

  def create
    @post=current_user.authored_posts.build(post_params)
    redirect_to user_post_url(current_user, @post) if @post.save
  end

  def show
    @post=Post.find(params[:id])
    @comment=Comment.new
    @comments=@post.comments
    @post_like=PostLike.new
    @comment_like=CommentLike.new

  end

  def index
    friend_ids = "SELECT friendee_id FROM friendships
                     WHERE  friender_id = :user_id"
    @posts= Post.where("author_id IN (#{friend_ids})
                     OR author_id = :user_id", user_id: current_user.id)

  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
