require_relative '../config/environment'

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

                                   
puts"                                   
      `.         .:////-.-.        
      -+/-``    -++++++++/.        
      `/+++/::-./++++++++.         
      ./+++++++++++++++++`         
       .//++++++++++++++-          
        ./++++++++++++/-           
         `-:+++++++++:`            
      `.-://+++++/:-`              
        `...--..`                  
".cyan                                   


#someone = User.create(username: "someone", display_name: "one_some", email: "someone@gmail.com")
#another_one = User.create(username: "another_one", display_name: "anotherone", email: "another_one@gmail.com")
#billy_bob = User.create(username: "billy_bob", display_name: "the_billster", email: "bill@gmail.com")


puts "HELLO WORLD"
old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil
# prompt = TTY::Prompt.new
# someone = User.create(username: "someone", display_name: "one_some", email: "someone@gmail.com")
# another_one = User.create(username: "another_one", display_name: "anotherone", email: "another_one@gmail.com")
# billy_bob = User.create(username: "billy_bob", display_name: "the_billster", email: "bill@gmail.com")
# binding.pry
AppDelegate.instance.clear_console
AppDelegate.instance.route_app
