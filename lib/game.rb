require 'ui'
require 'game_tree'
require 'game_state'
require 'game_options'

class Game
  attr_accessor :board, 
                :game_options,
                :game_type,
                :game_state,
                :move,
                :player_one,
                :player_two,
                :player_game_loop,
                :ui

  def initialize 
    @game_options = GameOptions.new
    @ui = UI.new
  end

  def generate_tree
    game_tree = GameTree.new
    @game_state = game_tree.generate_all_possible_moves 
  end

  def run
    require 'pry'
    binding.pry
    set_options

    if @game_options.game_type == 'human versus human'
      human_versus_ai_game_loop
    end
    @ui.display_grid(@game_state.board)
    game_loop
    @ui.display_grid(@game_state.board)
  end

  def human_versus_ai_game_loop
    generate_tree
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

private

  def set_options
    @ui.welcome 
    @ui.ask_for_player_one_type
    @game_options.set_player_one_type
    @ui.ask_for_player_two_type
    @game_options.set_player_two_type
    @game_options.set_game_type
  end

end