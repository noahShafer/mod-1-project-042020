require './lib/app_delegate.rb'
class LoginController
    attr_reader :prompt
    def initialize
        @prompt = AppDelegate.instance.prompt
        self.prompt_login_or_create_account
    end

    def prompt_login_or_create_account
        res = prompt.select("Login Or Create an Account?") do |menu|
            menu.choice 'Create Account'
            menu.choice 'Login'
        end

        if res == 'Login'
            self.prompt_login
        elsif res == 'Create Account'
            self.create_account
        end
    end

    def prompt_login
        username = prompt.ask("Username: ")
        password = prompt.mask("Password: ")
        self.auth_user(username, password)
    end

    def auth_user(username, password)
        user = User.find_by(username: username)
        if user == nil 
            p "Sorry, no user exists by that username"
            self.prompt_login
        elsif user.password != password
            p "Password Incorrect!"
            self.prompt_login
        else
            p "Welcome back to Twitter CLI (Route to home)"
            self.finished_login(user)
        end
    end

    def finished_login(user)
        AppDelegate.instance.set_current_user(user)
        AppDelegate.instance.route_app
    end

    def create_account
        username = prompt.ask("Username: ")
        display_name = prompt.ask("Display Name: ")
        email = prompt.ask("Email: ")
        password = prompt.mask("Password: ") 
        if username_exist?(username)
            p "Sorry, that username is already taken"
            self.create_account
        elsif email_exist?(email)
            p "Sorry, an account has already been created with that email"
            self.create_account
        else 
            p "Welcome to Twitter #{username} (Route To Home)"
            user = User.create(username: username, display_name: display_name, email: email, password: password)
            self.finished_login(user)
        end
    end

    def username_exist?(username)
        User.find_by(username: username) != nil
    end

    def email_exist?(email)
        User.find_by(email: email) != nil
    end
end 