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
  end

  def my_profile
    @user=current_user
    @posts=@user.authored_posts
  end

  private
  def friends?
    @user=User.find(params[:id])
    flash[:danger]="You must be friends to view someones profile."
    redirect_to(root_url) unless current_user.friends.include?(@user)
  end

end
