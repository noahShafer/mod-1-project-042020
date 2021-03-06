require './lib/app_delegate.rb'
require 'colorize'
class HomeController
    attr_reader :prompt
    def initialize
        @prompt = AppDelegate.instance.prompt
        self.display_feed
    end

    def display_feed
        AppDelegate.instance.clear_console
        AppDelegate.ascii_logo
        puts "                    HOME".bold.colorize(:cyan)
        tweets = self.get_user_tweets
        tweets.each_with_index {|tweet, index| 
            puts AsciiArt.new(tweet.user.profile_pic).to_ascii_art(width: 5) + "#{tweet.user.display_name} ".bold + "@#{tweet.user.username}".colorize( :color => :light_black) + " #{tweet.timestamp.strftime("%m/%d/%y %H:%M %p")}".colorize( :color => :light_black)
            puts "#{tweet.message}"
            puts "-----------------------------------------------".colorize(:color => :cyan) 
        }
        self.display_navigation_prompts
    end

    def display_navigation_prompts
        res = prompt.select("", %w(Large), active_color: :cyan) do |menu|
            menu.choice 'My Account'
            menu.choice 'Search User'
            menu .choice 'Create Tweet'
            menu.choice 'Refesh Feed'
        end

        if res == 'My Account'
            self.go_to_user_profile
        elsif res == 'Refesh Feed'
            self.display_feed
        elsif res == "Search User"
            AppDelegate.instance.clear_console
            SearchUserController.new
        elsif res == "Create Tweet"
            self.create_tweet_prompt
        end
    end

    def create_tweet_prompt
        AppDelegate.instance.clear_console
        message = prompt.ask("What's happening?: ")
        if message == nil
            puts "C'mon, you cant just tweet nothing".bold.colorize(:red)
            sleep 3.0
            AppDelegate.instance.clear_console
            self.create_tweet_prompt
        elsif message.length > 140
            puts "Tweet must be less than 140 characters".bold.colorize(:red)
            sleep 3.0
            AppDelegate.instance.clear_console
            self.create_tweet_prompt
        else
            AppDelegate.instance.current_user.create_tweet(message)
            AppDelegate.instance.clear_console
            self.display_feed
        end
    end

    def go_to_user_profile
        AppDelegate.instance.clear_console
        UserProfileController.new(user: nil, type: "current_user", subtype: nil)
    end

    def get_user_tweets
        AppDelegate.instance.current_user.fetch_feed
    end
end 