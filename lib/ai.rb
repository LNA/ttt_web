require 'game_rules'
require 'board'

class AI
  attr_accessor :current_player, :game_piece,
                :game_over, :max_player, :min_player, :play_space, 
                :rank, :space

  def initialize(game_rules, board, opponent_game_piece, ai_game_piece)
    @game_rules = game_rules
    @board = board
    @min_player = opponent_game_piece
    @max_player = ai_game_piece
  end

  def find_best_rank(open_spaces, spaces, current_player)
    @current_player = current_player
    @open_spaces = open_spaces
    build_branch_for_current_player(spaces)

    if @rank != 1 || @rank != 0
      @current_player = next_player
      build_branch_for_current_player(spaces)
    end
    @rank
  end

  #private

  def build_branch_for_current_player(spaces)
    spaces.each_with_index do |taken, space|
      if taken == nil        
        make_duplicate_board(spaces)
        @open_spaces.each do |open_space|
          set_duplicate_board(open_space)
          @rank = check_game_ranking
          if @rank = 1
            break
          end
        end
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

  def open_spaces(spaces) # Belongs in a different class
    @open_spaces = []

    spaces.each_with_index do |player, open_space|
      if player == nil
        @open_spaces << open_space
      end
    end
    @open_spaces
  end

  def make_duplicate_board(spaces)
    @duplicate_board = spaces.dup
  end
end