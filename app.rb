$: << File.expand_path(File.dirname(__FILE__)) + '/lib'
Dir[File.dirname(__FILE__) + '/lib/models/*.rb'].each {|file| require file }

require 'sinatra'
require 'game'
require 'game_state'
require 'game_tree'
require 'web_game'
require 'web_game_repository'
require 'repository'

Repository.register(:game, WebGameRepository)

configure do 
  enable :sessions 
end

class App < Sinatra::Application

  get '/' do 
    erb '/welcome'.to_sym
  end

  post '/' do 
    erb '/board'.to_sym
  end

  post '/new_game' do
    web_game_set_up
    web_game_state_set_up

    erb '/board'.to_sym
    redirect '/play'
  end

  get '/play' do
    p session[:game]
    p session[:game_state].board

    erb '/board'.to_sym
  end

  put '/move' do 
    p move
    session[:game_state] = session[:game_state].for(move)

    erb '/board'.to_sym
  end

  get '/game_over' do
    session.clear
    erb '/welcome'.to_sym

    redirect '/'
  end

  private

  def web_game_set_up
    @game = WebGameRepository.new_game(params)
    Repository.for(:game).store(@game)
    session[:game] = Repository.for(:game).current_game
  end

  def web_game_state_set_up
    @game_state = WebGameRepository.game_state
    Repository.for(:game).store(@game_state)
    session[:game_state] = Repository.for(:game).current_game_state
  end
end
