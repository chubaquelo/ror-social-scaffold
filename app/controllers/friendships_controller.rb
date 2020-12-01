class FriendshipsController < ApplicationController
  
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = current_user.friendships.build(params_friendship)
    @friendship.save
  end

  def destroy
  end

  private

  def params_friendship
    params.require(:friendship).permit(:friend_id)
  end

end