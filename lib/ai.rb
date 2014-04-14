require 'game_rules'
require 'board'

class AI
  attr_accessor :current_player, :duplicate_board, :game_piece,
                :game_over, :max_player, :min_player, :open_spaces, :play_space, 
                :rank, :space

  def initialize(game_rules, opponent_game_piece, ai_game_piece)
    @game_rules = game_rules
    @min_player = opponent_game_piece
    @max_player = ai_game_piece
    @open_spaces = []
  end

  WIN = 1
  TIE = 0
  LOSS = -1

  def find_best_rank(open_spaces, original_board, current_player)
    @open_spaces = open_spaces
    @original_board = original_board
    @current_player = current_player
    check_each_open_space_for_a_winning_rank
  end

  #private

  def unbeatable_rank
    (@rank == WIN) || (@rank == TIE)
  end

  def check_each_open_space_for_a_winning_rank 
    @open_spaces.each do |open_space|
      duplicate_board = @original_board.clone
      duplicate_board[open_space] = @current_player
      @rank = rank(duplicate_board)
      if unbeatable_rank
        return @rank
      else
        check_rankings(duplicate_board, test_space=0)
        fill_next_space_on_branch_with_next_player(duplicate_board)
      end
    end
    @current_player = next_player
    check_each_open_space_for_a_winning_rank 
  end

  def number_of_test_spaces(duplicate_board)
    duplicate_board.count(nil)
  end

  def fill_next_space_on_branch_with_next_player(duplicate_board)
    count = 0
    while count < number_of_test_spaces(duplicate_board)
      @current_player = next_player
      test_space = next_open_space(duplicate_board)
      duplicate_board[test_space] = @current_player
      check_rankings(duplicate_board, test_space)
      count += 1
    end
  end

  def check_rankings(duplicate_board, test_space)
    if unbeatable_rank
      return @rank
    elsif @rank == LOSS
      return_space_to_block_opponent_win(test_space)
    else
      fill_next_space_on_branch_with_next_player(duplicate_board)
    end
  end

  def return_space_to_block_opponent_win(test_space)
    return test_space
  end

  def next_open_space(duplicate_board)
    duplicate_board.each_with_index do |player, space|
      if player == nil
        return space 
      end
    end
  end

  def fill_next_open_space_with_current_player_game_piece
    duplicate_board[test_space] = current_player
  end

  def next_player
    @current_player == @min_player ? @max_player : @min_player
  end

  def rank(current_board)
    return 0  if @game_rules.tie?(current_board)
    return -1 if @game_rules.winner(current_board) == @min_player
    return 1  if @game_rules.winner(current_board) == @max_player
  end
end