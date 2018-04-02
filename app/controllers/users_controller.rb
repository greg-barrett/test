class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :friends?, only: :show


  def index
    @users=User.all
    @friend_request=FriendRequest.new
    @friendship=Friendship.new
  end

  def show
    @user=User.find(params[:id])

    @posts=@user.authored_posts
    @post_like=PostLike.new
  end

  def update
    @user=current_user
    if @user.update_attributes(user_params)
      flash[:success]="Successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def my_profile
    @post=Post.new
    @user=current_user
    @posts=@user.authored_posts
  end

  private
  def friends?
    @user=User.find(params[:id])
    unless current_user.friends.include?(@user)
      flash[:danger]="You must be friends to view someones profile."
      redirect_to(users_url)
    end
  end

  def user_params
    params.require(:user).permit(:image, :image_cache, :remove_image)
  end

end
