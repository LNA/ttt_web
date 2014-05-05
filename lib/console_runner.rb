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
    @ui.welcome_user
    player_one_type = @ui.get_player_type("one")
    player_two_type = @ui.get_player_type("two")
    @ui.display_grid(@board.spaces)
    until @game_rules.game_over?(@board.spaces)
      play_game(player_one_type, player_two_type) 
    end
    @ui.display_grid(@board.spaces)
  end

private
  
  def play_game(player_one, player_two)
    until @game_rules.game_over?(@board.spaces)
      turn(player_one)
      check_for_winner 
      turn(player_two)
      check_for_winner 
      @ui.display_grid(@board.spaces)
    end
  end

  def check_for_winner
    if @game_rules.game_over?(@board.spaces) 
      @ui.winner_message(@game_rules.winner(@board.spaces))
    end
  end

  def turn(current_player_type)
    make_human_move if current_player_type == "H"
    make_ai_move if current_player_type == "A"
  end

  def make_human_move
    @ui.ask_player_for_move
    @move = @ui.gets_move
    if @game_rules.valid?(@move, @board) == false
      @ui.invalid_move_message
      turn(@player_one_type)
    else
      @board.fill(@move, 'X')
    end
  end

  def make_ai_move
    @move = @ai.find_best_move(@board) 
    @board.fill(@move, 'O')
  end

  def respond_to_invalid_move
    @ui.invalid_move_message
    play_game
  end
end