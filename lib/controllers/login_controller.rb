require './lib/app_delegate.rb'
require 'colorize'
class LoginController
    attr_reader :prompt
    def initialize
        @prompt = AppDelegate.instance.prompt
        self.prompt_login_or_create_account
    end

    def prompt_login_or_create_account
        AppDelegate.instance.clear_console
        AppDelegate.ascii_banner
        AppDelegate.ascii_logo
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
        username = prompt.ask("Username: ", active_color: :cyan)
        password = prompt.mask("Password: ", active_color: :cyan)
        self.auth_user(username, password)
    end

    def auth_user(username, password)
        user = User.find_by(username: username)
        if user == nil 
            puts "Sorry, no user exists by that username".bold.colorize(:red)
            sleep 3.0
            self.prompt_login_or_create_account
        elsif user.password != password
            puts "Password Incorrect!".bold.colorize(:red)
            sleep 3.0
            self.prompt_login_or_create_account
        else
            puts "Welcome back to Twitter CLI...".bold.colorize(:cyan)
            sleep 3.0
            self.finished_login(user)
        end
    end

    def finished_login(user)
        AppDelegate.instance.set_current_user(user)
        AppDelegate.instance.route_app
    end

    def create_account
        username = prompt.ask("Username: ", active_color: :cyan)
        display_name = prompt.ask("Display Name: ", active_color: :cyan)
        email = prompt.ask("Email: ", active_color: :cyan)
        password = prompt.mask("Password: ", active_color: :cyan) 
        if username_exist?(username)
            puts "Sorry, that username is already taken".bold.colorize(:red)
            sleep 3.0
            self.prompt_login_or_create_account
        elsif email_exist?(email)
            puts "Sorry, an account has already been created with that email".bold.colorize(:red)
            sleep 3.0
            self.prompt_login_or_create_account
        else 
            puts "Welcome to Twitter #{username}...".bold.colorize(:cyan)
            sleep 3.0
            dog_photo = User.fetch_dog_photo
            user = User.create(username: username, display_name: display_name, email: email, password: password, profile_pic: dog_photo)
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