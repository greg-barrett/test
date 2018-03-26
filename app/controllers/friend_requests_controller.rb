class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
  def create
    @friend_request=FriendRequest.create(friend_request_params)
    redirect_to request.referrer
  end

  def sent_requests
    @sent_requests=current_user.pending_friendees
  end

  def received_requests
    @received_requests=current_user.pending_frienders
    @friendship=Friendship.new
  end

  private
  def friend_request_params
    params.require(:friend_request).permit(:requester_id, :requested_id)
  end
end
