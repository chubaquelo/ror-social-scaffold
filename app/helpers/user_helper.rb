module UserHelper
  def received_request(friend, current_user)
    friend.each do |user| 
      unless current_user.friend?(user)
        concat content_tag(:li, "#{user.name} Want to be your friend", class: "my-4") +
                          (link_to 'Accept ',  user_friendship_path(@friend_requests, user), method: :put, style: "color: #008000;") +
                          (link_to 'Reject',  user_friendship_path(@friend_requests, user), method: :delete, style: "color: #FF0000;")
                  
      end
    end
  end
end