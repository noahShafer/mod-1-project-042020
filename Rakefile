require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end

namespace :db_tasks do 
  task :rdb do 
    Rake::Task['db:drop'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
  end
end
