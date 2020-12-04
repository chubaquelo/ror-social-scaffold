module UserHelper
  def received_request(friend)
    if current_user.friend_requests.any?
      friend.each do |user|
        next if current_user.friend?(user)

        concat content_tag(:li, "#{user.name} Want to be your friend") +
               (link_to 'Accept ', user_friendship_path(@friend_requests, user),
                        method: :put, style: 'color: #008000;') +
               (link_to 'Reject', user_friendship_path(@friend_requests, user),
                        method: :delete, style: 'color: #FF0000;')
      end
    else
      concat content_tag(:p, "You didn't received any friend request yet.")
    end
  end

  def sent_requests(pending_requests)
    pending_requests.each do |req|
      concat content_tag(:li, "Waiting friend confirmation from  #{req.name}") unless current_user.friend?(req)
    end
  end

  def friendship_status_link(friend)
    if friend_request_status(friend) == false && current_user != friend && !current_user.friends.include?(friend)
      concat link_to 'Add as friend', user_friendships_path(current_user, friendship: { friend_id: friend.id }),
                     method: :post, class: 'profile-link'
    elsif friend_request_status(friend) == true
      concat content_tag(:p, 'Waiting for confirmation.')
    elsif current_user != friend
      concat content_tag(:p, 'You are already friends.')
    end
  end

  def friend_request_status(friend)
    if !current_user.pending_friends.include?(friend) && !friend.pending_friends.include?(current_user)
      false
    elsif current_user.pending_friends.include?(friend) || friend.pending_friends.include?(current_user)
      true
    end
  end
end
