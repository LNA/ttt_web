$: << File.expand_path(File.dirname(__FILE__)) + '/lib'
Dir[File.dirname(__FILE__) + '/lib/models/*.rb'].each {|file| require file }

require 'sinatra'
require 'game'
require 'game_state'
require 'game_tree'

class App < Sinatra::Application

  get '/' do 
    erb '/welcome'.to_sym
  end

  post '/' do 
    erb '/board'.to_sym
  end

  get '/play' do
    erb '/board'.to_sym
  end
end