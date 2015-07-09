class UserNotifier < ApplicationMailer

	def friend_requested(user_friendship_id)
		user_friendship = UserFriendship.find(user_friendship_id)
		@user = user_friendship.user
		@friend = user_friendship.friend

		mail to: @friend.email,
			 subject: "#{@user.first_name} sent you a friend request"
	end
end