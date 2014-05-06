$: << File.expand_path(File.dirname(__FILE__))
require 'game_options'
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
    @ui.welcome_user
    player_one_type = @ui.get_player_type("one")
    player_one_game_piece = @ui.get_player_game_piece
    player_two_type = @ui.get_player_type("two")
    player_two_game_piece = @ui.get_player_game_piece
    @ui.display_grid(@board.spaces)
    until @game_rules.game_over?(@board.spaces)
      play_game(player_one_type, player_two_type, player_one_game_piece, player_two_game_piece)
    end
    @ui.display_grid(@board.spaces)
  end

private

  def play_game(player_one_type, player_two_type, player_one_game_piece, player_two_game_piece)
    until @game_rules.game_over?(@board.spaces) 
      make_move(player_one_type, player_one_game_piece, player_two_game_piece)
      @ui.display_grid(@board.spaces)
      make_move(player_two_type, player_two_game_piece, player_one_game_piece)
      @ui.display_grid(@board.spaces)
    end
  end

  def make_move(current_player_type, game_piece, opponent_game_piece)
    make_human_move(current_player_type, game_piece, opponent_game_piece) if current_player_type == "H" 
    make_ai_move(game_piece, opponent_game_piece) if current_player_type == "A"
    check_for_winner
  end

  def make_human_move(current_player_type, game_piece, opponent_game_piece)
    unless @game_rules.game_over?(@board.spaces) 
      @ui.ask_player_for_move
      @move = @ui.gets_move
      check_validity_of_move(current_player_type, game_piece, opponent_game_piece)
    end
  end

  def check_validity_of_move(current_player_type, game_piece, opponent_game_piece)
    if @game_rules.valid?(@move, @board) == false
      @ui.invalid_move_message
      make_move(current_player_type, game_piece, opponent_game_piece)
    else
      @board.fill(@move, game_piece)
    end
  end

  def check_for_winner
    @ui.winner_message(@game_rules.winner(@board.spaces)) if @game_rules.game_over?(@board.spaces)
  end

  def make_ai_move(game_piece, opponent_game_piece)
    @move = @ai.find_best_move(@board, game_piece, opponent_game_piece)
    @board.fill(@move, game_piece)
  end

  def respond_to_invalid_move
    @ui.invalid_move_message
    play_game
  end
end