require 'ui'
require 'game_tree'
require 'game_state'
require 'game_options'

class Game
  attr_accessor :board, 
                :game_options,
                :game_state,
                :human_versus_human,
                :move,
                :player_one,
                :player_two,
                :player_game_loop,
                :ui

  def initialize 
    @game_options = GameOptions.new
    @ui = UI.new
  end

  def set_player_one_type
    @player_one = @ui.gets_player_one_type
    if @player_one == 'h'
      @player_one = "human"
    end
  end

  def set_player_two_type
    @player_two = @ui.gets_player_two_type
    if @player_two == 'h'
      @player_two = "human"
    end
  end

  def human_versus_human
    if @player_one && @player_two == 'human'
      return true
    end
  end

  def human_versus_ai
    if @player_one != @player_two
      return true
    end
  end

  def generate_tree
    game_tree = GameTree.new
    @game_state = game_tree.generate_all_possible_moves 
  end

  def run
    @ui.welcome 
    @ui.ask_for_player_one_type
    @game_options.set_player_one_type
    @ui.ask_for_player_two_type
    @game_options.set_player_two_type
    puts "it got here"
    require 'pry'
    binding.pry
    if human_versus_ai == true
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
end