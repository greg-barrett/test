class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  def friends
    @friends=current_user.friends
  end

  def create

    @friend_request=FriendRequest.where("requester_id = ? AND requested_id = ?", params[:friendship][:requester_id], current_user.id).first
    if @friend_request
      Friendship.create(friender_id: params[:friendship][:requester_id], friendee_id:current_user.id)
      Friendship.create(friender_id: current_user.id, friendee_id: params[:friendship][:requester_id])
      @friend_request.destroy
      flash[:success]="Friendship made!"
      redirect_to received_friend_requests_path
    else
      flash.now[:danger]="Unable to make friendship"
    end
  end

    def destroy
      @friendship=Friendship.find(params[:id])
      @friendship2=Friendship.where("friender_id = ? AND friendee_id = ?",  params[:friendship][:friendee_id], current_user.id).first
      @friendship.destroy
      @friendship2.destroy
      redirect_to users_url
    end
end
