class User < ActiveRecord::Base
    has_many :following_users, foreign_key: :followee_id, class_name: 'UserFollower'
    has_many :followers, through: :following_users
    has_many :followed_users, foreign_key: :follower_id, class_name: 'UserFollower'
    has_many :followees, through: :followed_users
    has_many :tweets

    def create_tweet(message)
        Tweet.create(user_id: self.id, message: message, timestamp: DateTime.now)
    end

    def follow_user(user)
        UserFollower.create(followee_id: user.id, follower_id: self.id)
    end

    def unfollow_user(user)
        UserFollower.find_by(followee_id: user.id, follower_id: self.id).destroy
        self.followees.delete(user)
        user.followers.delete(self)
    end
    
    def fetch_feed
        self.followees.map { |user| user.tweets}.flatten.concat(self.tweets).sort_by {|tweet| tweet.timestamp}.reverse
    end

end

# has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
# has_many :followers, through: :following_users