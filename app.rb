$: << File.expand_path(File.dirname(__FILE__)) + '/lib'
Dir[File.dirname(__FILE__) + '/lib/models/*.rb'].each {|file| require file }

require 'sinatra'
require 'game'
require 'game_state'
require 'game_tree'
require 'web_game'
require 'web_game_repository'

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

  post '/new_game/:player_one_piece/:player_two_piece' do
    put "it gets here"

    @game = Game.new(params)
    require 'pry'
    binding.pry
    
    redirect '/play'
  end

  put '/move/:space/:piece' do 
  end

end
