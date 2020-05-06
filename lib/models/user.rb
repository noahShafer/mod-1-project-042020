class User < ActiveRecord::Base
    has_many :following_users, foreign_key: :followee_id, class_name: 'UserFollower'
    has_many :followers, through: :following_users
    has_many :followed_users, foreign_key: :follower_id, class_name: 'UserFollower'
    has_many :followees, through: :followed_users
    has_many :tweets
end

# has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
# has_many :followers, through: :following_users