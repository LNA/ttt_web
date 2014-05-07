$: << File.expand_path(File.dirname(__FILE__))
require 'board'
require 'game_rules'
require 'ui'

class ConsoleRunner
  def initialize(ai, board, game_rules, ui)
    @ai = ai
    @board = board
    @game_rules = game_rules
    @ui = ui
  end

  def start_game
    welcome_message
    player_one      = player_type("one")
    player_two      = player_type("two")
    player_one_mark = gets_mark_for("one")
    player_two_mark = gets_mark_for("two")
    display_board
    until game_over?
      play_game(player_one, player_two, player_one_mark, player_two_mark)
    end
    display_board
  end

private
  def play_game(player_one, player_two, player_one_mark, player_two_mark)
    until game_over?
      make_move(player_one, player_one_mark, player_two_mark)
      display_board
      make_move(player_two, player_two_mark, player_one_mark)
      display_board
    end
  end

  def player_type(number)
    @ui.gets_type_for(number)
  end

  def gets_mark_for(player_number)
    @ui.gets_game_piece_for(player_number)
  end

  def welcome_message
    @ui.welcome_user
  end

  def game_over?
    @game_rules.game_over?(@board.spaces)
  end

  def display_board
    @ui.display_grid(@board.spaces)
  end

  def make_move(player, mark, opponent_mark)
    unless game_over?
      make_human_move(player, mark, opponent_mark) if player == "H"
      make_ai_move(mark, opponent_mark) if player == "A"
      check_for_winner if game_over?
      check_for_tie if game_over?
    end
  end

  def make_human_move(player, mark, opponent_mark)
    unless game_over?
      @ui.ask_player_for_move
      @move = @ui.gets_move
      check_validity_of_move(player, mark, opponent_mark)
    end
  end

  def check_validity_of_move(player, mark, opponent_mark)
    if @game_rules.valid?(@move, @board) == false
      @ui.invalid_move_message
      make_move(player, mark, opponent_mark)
    else
      @board.fill(@move, mark)
    end
  end

  def check_for_winner
    @ui.winner_message(@game_rules.winner(@board.spaces)) if @game_rules.winner(@board.spaces) != false
  end

  def check_for_tie
    @ui.tie_message if @game_rules.winner(@board.spaces) == false
  end

  def make_ai_move(mark, opponent_mark)
    @move = @ai.find_best_move(@board, mark, opponent_mark)
    @board.fill(@move, mark)
  end

  def respond_to_invalid_move
    @ui.invalid_move_message
    play_game
  end
end