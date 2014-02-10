$: << File.expand_path(File.dirname(__FILE__)) + '/lib'
Dir[File.dirname(__FILE__) + '/lib/models/*.rb'].each {|file| require file }

require 'sinatra'
require 'game'
require 'game_state'
require 'game_tree'
require 'web_game'

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
    # How do I pull the params from the buttons?
    player_one_piece = params[:player_one_piece]
    player_two_piece = params[:player_two_piece]


    @game = WebGame.new(player_one_piece, player_two_piece)

    redirect '/play'
  end

  put '/move/:space/:piece' do 
  end

end
