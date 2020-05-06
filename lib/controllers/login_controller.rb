require './lib/app_delegate.rb'
class LoginController
    attr_reader :prompt
    def initialize
        @prompt = AppDelegate.instance.prompt
        self.login_or_create_account
    end

    def login_or_create_account
        res = prompt.select("Login Or Create an Account?") do |menu|
            menu.choice 'Create Account'
            menu.choice 'Login'
        end

        if res == 'Login'
            self.login
        elsif res == 'Create Account'
            self.create_account
        end
    end

    def login
        prompt.ask("Username: ")
        prompt.mask("Password: ")
    end

    def create_account
        prompt.ask("Username: ")
        prompt.ask("Display Name: ")
        prompt.mask("Password: ") 
    end
end 