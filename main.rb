# Do not edit this file.

# This is the main application script. To run your web server (which you
# need to do before you can see your website in a browser), you would run
# `ruby main.rb` in Terminal.

# These lines invoke a tool call Bundler to automatically `require` several
# Ruby scripts that make this Web framework work.
require 'rubygems'
require 'bundler'
Bundler.require

require 'dotenv'
Dotenv.load

# This is an add-on to the Web framework, which scans your code anew each time
# you save it. Otherwise, you would have to `Control + C` to stop the server
# and then run it again--each time you changed your code.
require 'sinatra/reloader'

# This sets up a class called MyApp, which you will use in controllers.
require 'sinatra/base'
class MyApp < Sinatra::Base
  register Sinatra::Reloader
  set :sessions, true
  set :bind, '0.0.0.0'
  set :show_exceptions, true
  set :views, Proc.new { File.join(root, "app", "views") }
end

require 'tilt/erb'

if MyApp.settings.environment == :development
	DB = SQLite3::Database.new "test.db"
elsif MyApp.settings.environment == :test
	DB = SQLite3::Database.new "test.db"
end

DB.results_as_hash = true

Dir[File.dirname(__FILE__) + '/app/models/*.rb'].each {|file| require file }

Dir[File.dirname(__FILE__) + '/app/controllers/*.rb'].each {|file| require file }

