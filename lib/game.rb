require 'ui'
require 'game_tree'
require 'game_state'

class Game
  attr_accessor :ai,
                :board, 
                :game_state,
                :move,
                :player_one,
                :player_two,
                :player_game_loop,
                :ui

  def initialize 
    @ui = UI.new
    @player_one = player_one
    @player_two = player_two
  end

  def generate_tree
    game_tree = GameTree.new
    @game_state = game_tree.generate_all_possible_moves 
  end


  def run
    @ui.welcome 
    @ui.ask_for_opponent_type 
    @ui.display_grid(@game_state.board)
    game_loop
    @ui.display_grid(@game_state.board)
  end

  def game_loop
    player_game_loop
    if winner
      @ui.winner_message(winner)
    else ai_game_loop
      check_for_ai_final_state
    end
  end

  def player_game_loop 
    @ui.ask_for_move 
    move = @ui.gets_move
    if @game_state.valid(move)
      @game_state = @game_state.game_state_for(move)
    else
      @ui.invalid_move_message
      player_game_loop
    end
  end

  def ai_game_loop
    @game_state = @game_state.ai_play_best_move
    @ui.display_grid(@game_state.board)
  end

  def winner
    @game_state.game_over
  end

  def check_for_ai_final_state
    if winner 
      @ui.winner_message(winner)
    else
      game_loop
    end
  end
end