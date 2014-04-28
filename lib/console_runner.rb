$: << File.expand_path(File.dirname(__FILE__))
require 'ui'
require 'game_options'
require 'game_rules'

class ConsoleRunner
  def initialize(ai, board, game_rules, ui)
    @ai = ai
    @board = board
    @game_rules = game_rules
    @ui = ui
  end

  def start_game
    ui_set_up
    unless @game_rules.game_over?(@board.spaces)
      play_game 
    end
    @ui.display_grid(@game_rules.board)
  end

  def play_game
    turn(@player_one_type)
    check_for_winner 
    turn(@player_two_type)
    check_for_winner and play_game
  end

  def turn(player_type)
    if player_type == 'h'
      @move = @ui.gets_move
    else
      @ai.find_best_move 
    end
  end

  def respond_to_invalid_move
    @ui.invalid_move_message
    start_game_loop
  end

  def ui_set_up
    @ui.welcome_user
    @player_one_type = @ui.get_player_type("one")
    @player_two_type = @ui.get_player_type("two")
    @ui.display_grid(@board.spaces)
  end

  def player_one_ui_interaction
    @ui.display_grid(@game_rules.board)
    @ui.ask_player_for_move("one")
    @move = @ui.gets_move
  end
end