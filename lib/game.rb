require 'ui'
require 'game_tree'
require 'game_state'
require 'game_options'

class Game
  attr_accessor :board, 
                :game_options,
                :game_state,
                :game_type,
                :player_one,
                :player_two,
                :player_game_loop,
                :ui

  def initialize 
    @game_options = GameOptions.new
    @ui = UI.new
  end

  def run
    @ui.welcome
    set_player_options
    @game_options.set_game_type
    run_game_type
  end

  def human_versus_ai_game_loop
    human_game_loop
    ai_game_loop
  end

  def ai_game_loop
    if winner
      @ui.winner_message(winner)
    else ai_move
      check_for_ai_final_state
    end
  end

  def human_versus_human_game_loop
    player_one_game_loop
    if human_winner
      @ui.human_versus_human_winner_message(human_winner)
    else
      player_two_game_loop
      check_for_human_final_state
    end
  end

  def player_one_game_loop
    player_one_ui_interaction
    check_player_one_move_and_continue_loop
  end

  def player_one_ui_interaction
    @ui.ask_player_one_for_move
    @ui.display_grid(@human_game_state.board)
    @player_one_move = @ui.gets_move
  end

  def check_player_one_move_and_continue_loop
    if @human_game_state.valid(@player_one_move)
      @human_game_state.board[@player_one_move.to_i] = "X"
    else
      @ui.invalid_move_message
      player_one_game_loop
    end
  end

  def player_two_game_loop
    player_two_ui_interaction
    chesk_player_two_move_and_continue_loop
  end

  def chesk_player_two_move_and_continue_loop
    if @human_game_state.valid(@player_two_move)
      @human_game_state.board[@player_two_move.to_i] = "O"
    else
      @ui.invalid_move_message
    end
  end

  def player_two_ui_interaction
    @ui.ask_player_two_for_move
    @ui.display_grid(@human_game_state.board)
    @player_two_move = @ui.gets_move
  end

  def human_game_loop 
    @ui.ask_for_move 
    move = @ui.gets_move
    if @game_state.valid(move)
      @game_state = @game_state.game_state_for(move)
    else
      @ui.invalid_move_message
      player_game_loop
    end
  end

  def ai_move
    @game_state = @game_state.ai_play_best_move
    @ui.display_grid(@game_state.board)
  end

  def winner
    @game_state.game_over
  end

  def human_winner
    @human_game_state.game_over
  end

  def check_for_ai_final_state
    if winner 
      @ui.winner_message(winner)
    else
      human_versus_ai_game_loop
    end
  end

  def check_for_human_final_state
    if human_winner 
      @ui.human_versus_human_winner_message(human_winner)
    else
      human_versus_human_game_loop
    end
  end

private
  def set_player_options
    set_player_one_options
    set_player_two_options
  end

  def set_player_one_options
    @ui.ask_for_player_one_type
    @game_options.set_player_one_type
  end

  def set_player_two_options
    @ui.ask_for_player_two_type
    @game_options.set_player_two_type
  end

  def run_game_type
    if @game_options.game_type == 'human versus human'
      run_all_human_game
    else
      run_human_versus_ai_game
    end
  end

  def run_all_human_game
    @human_game_state = GameState.new('X', Array.new(9))
    human_versus_human_game_loop
  end

  def run_human_versus_ai_game
    generate_tree
    @ui.display_grid(@game_state.board)
    human_versus_ai_game_loop
  end

  def generate_tree
    game_tree = GameTree.new
    @game_state = game_tree.generate_all_possible_moves 
  end
end