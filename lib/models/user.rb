require './lib/app_delegate.rb'
require 'open-uri'
require 'net/http'
require 'json'
class User < ActiveRecord::Base
    has_many :following_users, foreign_key: :followee_id, class_name: 'UserFollower'
    has_many :followers, through: :following_users
    has_many :followed_users, foreign_key: :follower_id, class_name: 'UserFollower'
    has_many :followees, through: :followed_users
    has_many :tweets

    def create_tweet(message)
        Tweet.create(user_id: self.id, message: message, timestamp: DateTime.now)
    end

    def follow(user:)
        self.followees << user
    end

    def unfollow(user:)
        self.followees.delete(user)
    end
    
    def fetch_feed
        self.followees.map { |user| user.tweets}.flatten.concat(self.tweets).sort_by {|tweet| tweet.timestamp}.reverse
    end

    def is_following?(user)
        self.followees.where(id: user.id) != []
    end

    def self.search_users(search_text)
        current_user = AppDelegate.instance.current_user
        # self.where("username LIKE ? OR display_name LIKE ? AND username != ? OR display_name != ?", "%#{search_text}%", "%#{search_text}%", "%noah_shafer%", "%boa_acm%").order('username')
        self.where("username LIKE ? OR display_name LIKE ?", "%#{search_text}%", "%#{search_text}%").order('username').select {|u| u.username != current_user.username && u.display_name != current_user.display_name}

    end

    def self.fetch_dog_photo
        uri = URI.parse("https://dog.ceo/api/breeds/image/random")
        res = Net::HTTP.get_response(uri)
        res.body
        json = JSON.parse(self.get_response_body)
        json["message"]
    end

end

# has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
# has_many :followers, through: :following_users