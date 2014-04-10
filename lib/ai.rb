require 'game_rules'
require 'board'

class AI
  attr_accessor :current_player, :game_piece,
                :game_over, :max_player, :min_player, :open_spaces, :play_space, 
                :rank, :space

  def initialize(game_rules, board, opponent_game_piece, ai_game_piece)
    @game_rules = game_rules
    @board = board
    @min_player = opponent_game_piece
    @max_player = ai_game_piece
    @open_spaces = []
  end

  def find_best_rank(open_spaces, spaces, current_player)
    @current_player = current_player
    find_open_spaces(spaces)
    build_branch_for_current_player(spaces)
    build_tree_until_winning_rank_is_found(spaces)
  end

  #private

  def build_tree_until_winning_rank_is_found(spaces)
    unless @rank == 1
      @current_player = next_player
      build_branch_for_current_player(spaces)
    end
    @rank
  end

  def build_branch_for_current_player(spaces)
    spaces.each_with_index do |taken, space|
      if taken == nil        
        make_duplicate_board(spaces)
        check_each_open_space
      end
    end
  end

  def check_each_open_space
    @open_spaces.each do |open_space|
      set_duplicate_board(open_space)
      @rank = check_game_ranking
      if @rank == 1
        break # check with Mike
      end
    end
  end

  def set_duplicate_board(open_space)
    @duplicate_board[open_space] = @current_player 
  end

  def rank_next_empty_space(spaces)
    if @game_rules.game_over(@duplicate_board) == false
      find_best_rank(@open_spaces, spaces, @current_player)
    end
  end

  def check_game_ranking
    rank(@duplicate_board)
  end

  def next_player
    @current_player == @min_player ? @max_player : @min_player
  end

  def rank(spaces)
    return 0  if @game_rules.tie?(spaces)
    return -1 if @game_rules.winner(spaces) == @min_player
    return 1  if @game_rules.winner(spaces) == @max_player
  end

  def find_open_spaces(spaces)
    spaces.each_with_index do |player, open_space|
      if player == nil
        @open_spaces << open_space
      end
    end
  end

  def make_duplicate_board(spaces)
    @duplicate_board = spaces.dup
  end
end