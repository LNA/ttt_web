$: << File.expand_path(File.dirname(__FILE__)) + '/lib'
Dir[File.dirname(__FILE__) + '/lib/models/*.rb'].each {|file| require file }

require 'sinatra'
require 'ai'
require 'board'
require 'game_rules'
require 'game'
require 'repository'
require 'web_game'
require 'web_game_store'

# Repository.register(:game, WebGameStore)

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
    web_game_rules_set_up
    session[:game_rules].current_player = session[:game].player_one_piece

    redirect to('/play')
  end

  get '/play' do
    @board = session[:board].spaces
    erb '/board'.to_sym
  end

  post '/move' do
    move = params.fetch("square")
    session[:board].fill(move.to_i, session[:settings].current_player)
    check_for_winner
    session[:game_rules].current_player = session[:game_rules].next_player
    @board = session[:board].spaces

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
    session[:game] = WebGameStore.new_game(params)
    # Repository.for(:game).store(@game)
    # session[:game] = Repository.for(:game).current_game
  end

  def web_game_rules_set_up
    session[:game_rules] = WebGameStore.game_rules
    # Repository.for(:game).store(@game_rules)
    # session[:game_rules] = Repository.for(:game).current_game_rules
  end

  def check_for_winner
    if session[:game_rules].game_over?(@board.spaces)
      redirect '/winner'
    end
  end
end
