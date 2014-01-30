$: << File.expand_path(File.dirname(__FILE__)) + '/lib'
Dir[File.dirname(__FILE__) + '/lib/models/*.rb'].each {|file| require file }

require 'sinatra'

class App < Sinatra::Application

  get '/' do 
    'Welcome to Tic Tac Toe!'
  end
end