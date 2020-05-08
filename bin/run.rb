require_relative '../config/environment'


#someone = User.create(username: "someone", display_name: "one_some", email: "someone@gmail.com")
#another_one = User.create(username: "another_one", display_name: "anotherone", email: "another_one@gmail.com")
#billy_bob = User.create(username: "billy_bob", display_name: "the_billster", email: "bill@gmail.com")

old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil
# prompt = TTY::Prompt.new
# someone = User.create(username: "someone", display_name: "one_some", email: "someone@gmail.com")
# another_one = User.create(username: "another_one", display_name: "anotherone", email: "another_one@gmail.com")
# billy_bob = User.create(username: "billy_bob", display_name: "the_billster", email: "bill@gmail.com")
# binding.pry
AppDelegate.instance.clear_console                                
AppDelegate.instance.route_app
