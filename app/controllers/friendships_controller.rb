class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = current_user.friendships.build(params_friendship)
    if @friendship.save
      flash[:notice] = 'Friendship was saved correctly.'
      redirect_back(fallback_location: new_user_friendship_path)
    else
      render :create
    end
  end

  def update
    user = User.find(params[:user_id])
    if current_user.friend_requests.include?(user)
      current_user.confirm_friend(user)
      flash[:notice] = 'Friendship was confirmed correctly.'
      redirect_back(fallback_location: user_path)
    else
      flash[:notice] = 'Friendship was not modified.'
      render :update
    end
  end

  def destroy
    user = User.find(params[:user_id])
    fsh = Friendship.find_by(user_id: params[:user_id], friend_id: current_user.id)

    flash[:notice] = if current_user.friend_requests.include?(user) && fsh.delete
                       'Friendship was rejected.'
                     else
                       'Friendship request was not modified.'
                     end
    redirect_back(fallback_location: user_path)
  end

  private

  def params_friendship
    params.require(:friendship).permit(:friend_id)
  end
end
