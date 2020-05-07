require './lib/app_delegate.rb'
require 'colorize'
class HomeController
    attr_reader :prompt
    def initialize
        @prompt = AppDelegate.instance.prompt
        self.display_feed
    end

    def display_feed
        puts "TWITTER".bold.colorize(:cyan)
        tweets = self.get_user_tweets
        tweets.each_with_index {|tweet, index| 
            puts "-----------------------------------------------".colorize( :color => :cyan)
            puts "#{tweet.user.display_name} ".bold + "@#{tweet.user.username}".colorize( :color => :light_black)
            puts "#{tweet.message}"
            puts "-----------------------------------------------".colorize(:color => :cyan)  if index == tweets.count - 1
        }
        self.display_navigation_prompts
    end

    def display_navigation_prompts
        res = prompt.select("", %w(Large), active_color: :cyan) do |menu|
            menu.choice 'My Account'
            menu.choice 'Refesh Feed'
        end

        if res == 'My Account'
            self.go_to_user_profile
        elsif res == 'Refesh Feed'
            self.display_feed
        end
    end

    def go_to_user_profile
        UserProfileController.new
        AppDelegate.instance.clear_console
    end

    def get_user_tweets
        AppDelegate.instance.current_user.fetch_feed
    end
end 