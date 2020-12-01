class FriendshipsController < ApplicationController
  
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = current_user.friendships.build(params_friendship)
    if @friendship.save
      flash[:notice] = 'Friendship was saved correctly.'
      redirect_back(fallback_location: new_user_friendship_path)
    end
  end

  def update
    @friendship = current_user.friendships.find_by(friend_id: params[:friend_id])
    if current_user.confirm_friend(friendship)
      flash[:notice] = "Friendship was confirmed correctly."
      redirect_back(fallback_location: user_path)
    end
  end

  def destroy
  end

  private

  def params_friendship
    params.require(:friendship).permit(:friend_id)
  end

end