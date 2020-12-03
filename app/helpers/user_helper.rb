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

  def friendship_status_link(user)
    if friendship_status_helper(user) == true
      concat link_to 'Add as friend', user_friendships_path(current_user, friendship: { friend_id: user.id }), method: :post, class: 'profile-link'
    elsif friendship_status_helper(user) == false
      concat content_tag(:p, 'Waiting for confirmation.')
    elsif friendship_status_helper(user).nil? && user != current_user
      concat content_tag(:p, 'You are already friends.')
    end
  end

  def friendship_status_helper(user)
    if !current_user.friends.include?(user) && !current_user.pending_friends.include?(user) && !current_user.friend_requests.include?(user) && current_user != user
      return true
    end
    if !current_user.friends.include?(user) && (current_user.pending_friends.include?(user) || current_user.friend_requests.include?(user))
      return false
    end

    nil
  end
end
