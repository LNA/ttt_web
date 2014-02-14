$: << File.expand_path(File.dirname(__FILE__)) + '/lib'
Dir[File.dirname(__FILE__) + '/lib/models/*.rb'].each {|file| require file }

require 'sinatra'
require 'game'
require 'game_state'
require 'game_tree'
require 'web_game'
require 'web_game_store'
require 'repository'

Repository.register(:game, WebGameStore)

configure do 
  enable :sessions 
  set :session_secret, "My session secret"
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

    redirect to('/play')
  end

  get '/play' do
    @board = session[:game_state].board
    erb '/board'.to_sym
  end

  post '/move' do 
    move = params.fetch("square")

    session[:game_state].board[move.to_i] = session[:game_state].current_player
    check_for_winner
    session[:game_state].current_player = session[:game_state].next_player    
    @board = session[:game_state].board  
    
    erb '/board'.to_sym
  end

  get '/winner' do 
    erb '/game_over'.to_sym
  end

  get '/play_again' do
    session.clear
    erb '/welcome'.to_sym

    redirect '/'
  end
  
  private

  def web_game_set_up
    @game = WebGameStore.new_game(params)
    Repository.for(:game).store(@game)
    session[:game] = Repository.for(:game).current_game
  end

  def web_game_state_set_up
    @game_state = WebGameStore.game_state
    Repository.for(:game).store(@game_state)
    session[:game_state] = Repository.for(:game).current_game_state
  end

  def check_for_winner
    if session[:game_state].game_over
      redirect '/winner'
    end
  end
end
