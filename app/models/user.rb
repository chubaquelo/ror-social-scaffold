class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  # has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :confirmed_friendships, -> { where confirmed: true }, class_name: "Friendship"
  has_many :friends, through: :confirmed_friendships

  has_many :pending_friendships, -> { where confirmed: nil }, class_name: "Friendship", foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend

  has_many :inverted_friendships, -> { where confirmed: nil }, class_name: "Friendship", foreign_key: 'friend_id'
  has_many :friend_requests, through: :inverted_friendships, source: :user
  # def friends
  #   friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
  #   friends_array += inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
  #   friends_array.compact
  # end

  # def pending_friends
  #   friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  # end

  # def friend_requests
  #   inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  # end

  # def confirm_friend(friend)
  #   friendship = inverse_friendships.find { |fship| fship.user == friend }
  #   friendship.confirmed = true
  #   friendship.save

  #   f_friendship = Friendship.new(user_id: friendship.friend_id, friend_id: friendship.user_id, confirmed: true)
  #   f_friendship.save
  # end

  def friend?(user)
    friends.include?(user)
  end
end
