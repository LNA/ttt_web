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
    @ui.display_grid(@board.spaces)
  end

  def play_game
    turn(@player_one_type)
    check_for_winner 
    @ui.display_grid(@board.spaces)
    turn(@player_two_type)
    @ui.display_grid(@board.spaces)
    if @game_rules.game_over?(@board.spaces) 
      @ui.winner_message(@game_rules.winner(@board.spaces))
    else
      play_game
    end
  end

  def check_for_winner
    if @game_rules.game_over?(@board.spaces) 
      @ui.winner_message(@game_rules.winner(@board.spaces))
    end
  end

  def turn(current_player_type)
    if current_player_type == "H"
      @ui.ask_player_for_move
      @move = @ui.gets_move
      if @game_rules.valid?(@move, @board) == false
        @ui.invalid_move_message
        turn(@player_one_type)
      else
        @board.fill(@move, 'X')
      end
    else
      @move = @ai.find_best_move(@board) 
      @board.fill(@move, 'O')
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
end