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
        if user != nil 
            self.current_user_id = user.id
        else
            self.current_user_id = nil
        end
    end

    def current_user
        if current_user_id == nil
            nil
        else
            User.find_by(id: self.current_user_id)
        end
    end

    def clear_console
        system "clear"
    end

    def self.ascii_logo
        puts"                                   
                  `.    `://--`    
                  `//:-.:++++:     
                  `:+++++++++`     
                  :++++++/.      
                  .-/++/:.                  
        ".cyan  
        puts "-----------------------------------------------".colorize(:cyan)
    end

    def self.ascii_banner
        puts "-------------------------------------------------------------------------".white
        puts "

                                                                                                                
                                                `..---..`                         
                    `-                      -/+++++++++/-```.-/.                
                    :+/-                  ./+++++++++++++++++:` `                
                    `++++/-`              .++++++++++++++++++::/:`                
                    /++++++/-.           /+++++++++++++++++++:.                  
                    -+++++++++/:-.`      +++++++++++++++++++.                    
                    -/+++++++++++++//:::+++++++++++++++++++.                    
                    `:--/++++++++++++++++++++++++++++++++++++`                    
                    /++++++++++++++++++++++++++++++++++++++/                     
                    `/+++++++++++++++++++++++++++++++++++++.                     
                    `-/++++++++++++++++++++++++++++++++++:                      
                        .:/++++++++++++++++++++++++++++++/                       
                        .///+++++++++++++++++++++++++++++/                        
                        ./+++++++++++++++++++++++++++++:                         
                            .:/++++++++++++++++++++++++/.                          
                            `.:+++++++++++++++++++/-                            
                            `.-:+++++++++++++++++++/.                              
                    `.-::://++++++++++++++++++++/-`                                
                    `.-:/++++++++++++++++/:-.                                    
                            `...------..``                                         

                            
                                                                                
        ".cyan
        puts "--------------------------------------------------------------------------".white

        puts "
        __      __   _                    _         _____        _ _   _           _ 
        \\ \\    / /__| |__ ___ _ __  ___  | |_ ___  |_   _|_ __ _(_) |_| |_ ___ _ _| |
         \\ \\/\\/ / -_) / _/ _ \\ '  \\/ -_) |  _/ _ \\   | | \\ V  V / |  _|  _/ -_) '_|_|
          \\_/\\_/\\___|_\\__\\___/_|_|_\\___|  \\__\\___/   |_|  \\_/\\_/|_|\\__|\\__\\___|_| (_)
                                                                                    
        ".cyan.bold    
    end
end