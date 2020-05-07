require './lib/app_delegate.rb'
require 'colorize'
class UserProfileController
    attr_reader :prompt
    def initialize
        @prompt = AppDelegate.instance.prompt
        self.display_user_profile
    end

    def user
        AppDelegate.instance.current_user
    end

    def display_user_profile
        self.profile_info
        self.user_tweets
        self.display_navigation_prompts
    end

    def profile_info
        puts "-----------------------------------------------".colorize( :color => :cyan)
        puts "#{self.user.display_name} ".bold 
        puts "@#{self.user.username}".colorize( :color => :light_black)
        puts "#{self.user.followees.count} ".bold + "Following  ".colorize(:light_black) + "#{self.user.followers.count} ".bold + "Followers".colorize(:light_black)
        puts "-----------------------------------------------".colorize(:color => :cyan)
    end

    def user_tweets
        tweets = self.user.tweets
        puts "Tweets".bold.colorize(:cyan)
        tweets.each_with_index { |tweet, index| 
            puts "#{tweet.user.display_name} ".bold + "@#{tweet.user.username}".colorize( :color => :light_black)
            puts "#{tweet.message}"
            puts "-----------------------------------------------".colorize(:color => :cyan) 
        }
    end

    def display_navigation_prompts
        res = prompt.select("", %w(Large), active_color: :cyan) do |menu|
            menu.choice 'Back To Home'
            menu.choice 'Followers'
            menu.choice 'Following'
            menu.choice 'Change Display Name'
        end

        if res == 'My Account'
            self.go_to_account_page
        elsif res == 'Refesh Feed'
            self.display_feed
        end
    end

    def go_to_account_page
        UserProfileController.new
    end

    def get_user_tweets
        AppDelegate.instance.current_user.fetch_feed
    end
end 