class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :statuses
  has_many :user_friendships

  has_many :friends, -> { where(user_friendships: { state: "accepted"}) }, through: :user_friendships

  has_many :pending_user_friendships, -> { where user_friendships: { state: "pending"}}, through: :user_friendships

  has_many :pending_friends, -> { where user_friendships: { state: "pending" } }, through: :user_friendships, source: :friend

  has_many :requested_user_friendships, -> { where user_friendships: { state: "requested"}}, through: :user_friendships

  has_many :requested_friends, -> { where user_friendships: { state: "requested" } }, through: :user_friendships, source: :friend

  has_many :blocked_user_friendships, -> { where user_friendships: { state: "blocked"}}, through: :user_friendships

  has_many :blocked_friends, -> { where user_friendships: { state: "blocked" } }, through: :user_friendships, source: :friend

  def full_name
  	first_name + " " + last_name
  end

  def gravatar_url
    stripped_email = email.strip
    downcased_email = stripped_email.downcase
    hash = Digest::MD5.hexdigest(downcased_email)
    "http://gravatar.com/avatar/#{hash}"
  end

  def has_blocked?(other_user)
    blocked_friends.include?(other_user)
  end

  def to_param
  	profile_name
  end
end


