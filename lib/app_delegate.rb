require 'tty-prompt'
require 'singleton'
class AppDelegate
    include Singleton
    attr_reader :prompt
    attr_accessor :current_user_id
    def initialize
        @prompt = TTY::Prompt.new
    end

    def route_app
        if self.current_user == nil
            LoginController.new
        else
            HomeController.new
            AppDelegate.instance.clear_console
        end
    end

    def set_current_user(user)
        self.current_user_id = user.id
    end

    def current_user
        User.find_by(id: self.current_user_id)
    end

    def clear_console
        system "clear"
    end
end