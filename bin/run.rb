require_relative '../config/environment'
# prompt = TTY::Prompt.new
someone = User.create(username: "someone", display_name: "one_some", email: "someone@gmail.com")
another_one = User.create(username: "another_one", display_name: "anotherone", email: "another_one@gmail.com")
binding.pry
# AppDelegate.instance.route_app
# # p AppDelegate.shared.prompt