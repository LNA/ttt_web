$: << File.expand_path(File.dirname(__FILE__))
require 'game'
require 'ui'
require 'game_options'
require 'game_state'

class ConsoleRunner
  def initialize(ui, game_state, game)
    @ui = ui
    @game_state = game_state
    @game = game
  end

  def start_game
    ui_set_up
    start_game_loop
    check_player_one_move
    @ui.display_grid(@game_state.board)
    check_for_player_one_win
  end

  def start_game_loop
    if @player_one_type == "H"
     player_one_ui_interaction
    else
      @game_state.ai_play_best_move
    end
    transition_from_player_one_to_player_two_game_loop
  end

  def transition_from_player_one_to_player_two_game_loop
    check_player_one_move
    end_player_one_loop
  end

  def check_player_one_move
    if @game_state.valid(@move) == true
      @game_state.board[@move.to_i] =  'X'
      @ui.display_grid(@game_state.board)
    else
      respond_to_player_one_invalid_move
    end
  end

  def end_player_one_loop
    if @game_state.game_over
      @ui.winner_message(winner)
    else
      player_two_game_loop
      check_for_player_two_move
      check_final_state
    end
  end

  def winner
    @game_state.game_over
  end

  def check_final_state
    if @game_state.game_over 
      @ui.winner_message(winner)
    else
      start_game_loop
    end
  end

  def respond_to_player_one_invalid_move
    @ui.invalid_move_message
    start_game_loop
  end

  def player_two_game_loop
    if @player_two_type == "H"
      @ui.ask_player_for_move("two")
      @move = @ui.gets_move
    else
      @game_state.ai_play_best_move
    end
  end

  def check_for_player_two_move
    if @game_state.valid(@move) == true
      @game_state.board[@move.to_i] =  'O'
    else
      @ui.invalid_move_message
    end
  end


  def ui_set_up
    @ui.welcome_user
    @player_one_type = @ui.get_player_type("one")
    @player_two_type = @ui.get_player_type("two")
    @ui.display_grid(@game_state.board)
  end

  def player_one_ui_interaction
    @ui.display_grid(@game_state.board)
    @ui.ask_player_for_move("one")
    @move = @ui.gets_move
  end
end