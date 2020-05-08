require './lib/app_delegate.rb'
require './lib/views/prompt_view.rb'
require 'colorize'
class SearchUserController
    attr_reader :prompt, :user
    def initialize
        @prompt = AppDelegate.instance.prompt
        @user = AppDelegate.instance.current_user
        self.get_search_input
    end

    def get_search_input
        AppDelegate.instance.clear_console
        AppDelegate.ascii_logo
        puts "                SEARCH USERS".bold.colorize(:cyan)
        search_text = prompt.ask("Search Users: ")
        self.search_and_display_users(search_text)
    end

    def search_and_display_users(search_text)
        users = User.search_users(search_text)
        puts "Users".bold.colorize(:cyan)
        choices = []
        users.each_with_index { |user, index| 
            choices << PromptView.new(user, "user", "user", index == 0)
        }
        self.display_prompts(choices)
    end

    def display_prompts(choices)
        choices << PromptView.new(nil, "Back To Home", nil, false)
        choices << PromptView.new(nil, "Search For Another User", nil, false)
        res = prompt.select("", active_color: :cyan) do |menu|
            choices.each {|choice| 
                menu.choice choice.view_str
            }
        end

        choice = choices.find {|e| e.view_str == res}
        if choice.choice_str == 'Back To Home'
            self.go_back_to_home
        elsif choice.choice_str == 'Search For Another User'
            self.get_search_input
        elsif choice.choice_str == "user"
            AppDelegate.instance.clear_console
            UserProfileController.new(user: choice.model, type: "user", subtype: "searching_users")
        end
    end

    def go_back_to_home
        AppDelegate.instance.clear_console
        HomeController.new
    end
end 