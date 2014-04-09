require 'game_rules'
require 'board'

class AI
  attr_accessor :current_player, :game_piece, 
                :game_over, :max_player, :min_player, :play_space, :space

  def initialize(game_rules, board, opponent_game_piece, ai_game_piece)
    @game_rules = game_rules 
    @board = board
    @min_player = opponent_game_piece
    @max_player = ai_game_piece
  end

  def find_best_move(open_spaces, spaces, current_player)
    @current_player = current_player
    @open_spaces = open_spaces

    spaces.each_with_index do |taken, space|
      if taken == nil
        make_duplicate_board(spaces)
        replace_current_empty_space_with_current_player_game_piece
        check_game_ranking
        remove_first_open_space
        @current_player = next_player
        rank_next_empty_space(spaces)   
      end
    end
    @rank
  end

  def rank_next_empty_space(spaces)
    until @open_spaces == []
      if @game_rules.game_over(@duplicate_board) == false
        find_best_move(@open_spaces, spaces, @current_player) 
      end   
    end 
  end

  def replace_current_empty_space_with_current_player_game_piece
    if @open_spaces.count > 0
      @duplicate_board[@open_spaces.first] = @current_player
    end
  end

  def check_game_ranking
    if @game_rules.game_over(@duplicate_board) != false
      @rank = rank(@duplicate_board)
    end
    @rank
  end

  def remove_first_open_space
    @open_spaces.shift
  end

  def next_player
    @current_player == @min_player ? @max_player : @min_player
  end

  def rank(spaces)
    return 0  if @game_rules.tie?(spaces)
    return -1 if @game_rules.winner(spaces) == @min_player
    return 1  if @game_rules.winner(spaces) == @max_player
  end

  def open_spaces(spaces)
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