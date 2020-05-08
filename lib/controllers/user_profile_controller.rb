require './lib/app_delegate.rb'
require 'colorize'
class UserProfileController
    attr_reader :prompt, :user, :type, :subtype
    def initialize(user:, type:, subtype:)
        @prompt = AppDelegate.instance.prompt
        @type = type
        @subtype = subtype
        @user = type == "current_user" ? AppDelegate.instance.current_user : User.find_by(id: user.id)
        self.display_user_profile
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
        if self.type == "current_user"
            res = prompt.select("", %w(Large), active_color: :cyan) do |menu|
                menu.choice 'Back To Home'
                menu.choice 'Followers'
                menu.choice 'Following'
                menu.choice 'Change Display Name'
            end
    
            if res == 'Back To Home'
                self.go_back_to_home
            elsif res == 'Followers'
                AppDelegate.instance.clear_console
                FollowersController.new(type: "followers")
            elsif res == 'Following'
                AppDelegate.instance.clear_console
                FollowersController.new(type: "following")
            elsif res == 'Change Display Name'
                self.change_display_name_prompt
            end
        elsif self.type == "user"
            choices = []
            subtype == "searching_users" ? choices << 'Back To Search Users' : choices << "Back To " + subtype.capitalize
            choices << 'Back To Home'
            AppDelegate.instance.current_user.is_following?(self.user) ? choices << 'Unfollow' : choices << 'Follow'
            res = prompt.select("", %w(Large), active_color: :cyan) do |menu|
                choices.each {|c|
                    menu.choice c
                }
            end
    
            if res == 'Back To Search Users'
                self.go_back_to_search_users

            elsif res == "Back To Home"
                self.go_back_to_home
            elsif res == 'Follow'
                AppDelegate.instance.current_user.follow(user: user)
                AppDelegate.instance.clear_console
                UserProfileController.new(user: self.user, type: "user", subtype: self.subtype)
            elsif res == 'Unfollow'
                AppDelegate.instance.current_user.unfollow(user: user)
                AppDelegate.instance.clear_console
                UserProfileController.new(user: self.user, type: "user", subtype: self.subtype)
            elsif res == "Back To " + subtype.capitalize
                AppDelegate.instance.clear_console
                FollowersController.new(type: self.subtype)
            end
        end
    end

    def go_back_to_home
        AppDelegate.instance.clear_console
        HomeController.new
    end

    def go_back_to_search_users
        AppDelegate.instance.clear_console
        SearchUserController.new
    end

    def change_display_name_prompt
        new_display_name = prompt.ask("New Display Name: ")
        current_user = AppDelegate.instance.current_user
        current_user.display_name = new_display_name
        current_user.save
        p current_user.display_name
        AppDelegate.instance.clear_console
        UserProfileController.new(user: nil, type: "current_user", subtype: nil)
    end 
end 