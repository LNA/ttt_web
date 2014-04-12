require 'game_rules'
require 'board'

class AI
  attr_accessor :current_player, :duplicate_board, :game_piece,
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
    build_tree_until_winning_rank_is_found(@duplicate_board) 
  end

  #private

  def build_branch_for_current_player(spaces)
    spaces.each_with_index do |taken, space|
      if taken == nil      
        make_duplicate_board(spaces)
        check_each_open_space(@duplicate_board)
      end
    end
  end

  def build_tree_until_winning_rank_is_found(spaces)
    until unbeatable_rank
      build_branch_for_current_player(@duplicate_board)
    end
    @rank
  end

  def unbeatable_rank
    (@rank == 1) || (@rank == 0)
  end

  def check_each_open_space(spaces)
    until unbeatable_rank
      @open_spaces.each do |open_space|
        # spaces variable is right
        require 'pry'
        binding.pry
        set_duplicate_board(open_space)
        #spaces variable is wrong
        @rank = check_game_ranking
        reset_duplicate_board(spaces)
      end
      @current_player = next_player
    end
  end

  def set_duplicate_board(open_space)
    # somehow is resetting spaces variable to equal @duplicate_board.
    # Why are they this connected ???
    @duplicate_board[open_space] = @current_player 
  end

  def reset_duplicate_board(spaces)
    @duplicate_board = spaces
  end

  def check_game_ranking
    rank(@duplicate_board)
  end

  def next_player
    @current_player == @min_player ? @max_player : @min_player
  end

  def rank(current_board)
    return 0  if @game_rules.tie?(current_board)
    return -1 if @game_rules.winner(current_board) == @min_player
    return 1  if @game_rules.winner(current_board) == @max_player
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