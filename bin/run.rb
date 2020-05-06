require_relative '../config/environment'

someone = User.create(username: "someone", display_name: "one_some", email: "someone@gmail.com")
another_one = User.create(username: "another_one", display_name: "anotherone", email: "another_one@gmail.com")

binding.pry
puts "HELLO WORLD"
