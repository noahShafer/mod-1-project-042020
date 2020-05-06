require 'tty-prompt'
require 'singleton'
class AppDelegate
    include Singleton
    attr_reader :prompt

    def initialize
        @prompt = TTY::Prompt.new
    end

    def route_app
        LoginController.new
    end
end