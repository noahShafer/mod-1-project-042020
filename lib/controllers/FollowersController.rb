require './lib/app_delegate.rb'
require './lib/views/prompt_view.rb'
require 'colorize'
class FollowersController
    attr_reader :type, :prompt
    def initialize(type:)
        @prompt = AppDelegate.instance.prompt
        @type = type
        self.users_list
    end

    def users_list
        users = type == "followers" ? AppDelegate.instance.current_user.followers : AppDelegate.instance.current_user.followees
        puts "#{type == "followers" ? "Followers" : "Following"} ".bold.colorize(:cyan)
        choices = []
        users.each_with_index { |user, index| 
            choices << PromptView.new(user, "user", "user", index == 0)
        }
        self.display_prompts(choices)
    end

    def display_prompts(choices)
        choices << PromptView.new(nil, "Back To My Account", nil, false)
        choices << PromptView.new(nil, "Back To Home", nil, false)
        res = prompt.select("", active_color: :cyan) do |menu|
            choices.each {|choice| 
                menu.choice choice.view_str
            }
        end

        choice = choices.find {|e| e.view_str == res}
        if choice.choice_str == 'Back To Home'
            self.go_back_to_home
        elsif choice.choice_str == 'Back To My Account'
            AppDelegate.instance.clear_console
            self.go_back_to_my_account
        elsif choice.choice_str == "user"
            AppDelegate.instance.clear_console
            UserProfileController.new(user: choice.model, type: "user", subtype: self.type)
        end
    end

    def go_back_to_my_account
        AppDelegate.instance.clear_console
        UserProfileController.new(user: nil, type: "current_user", subtype: nil)
    end

    def go_back_to_home
        AppDelegate.instance.clear_console
        HomeController.new
    end
end 