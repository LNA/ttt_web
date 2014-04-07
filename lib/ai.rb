require 'game_rules'
class AI
  attr_accessor :game_piece, :game_over
  def initialize(game_rules)
    @game_rules = game_rules 
  end

  def find_best_move(spaces, depth=0)
    spaces.each_with_index do |player, space|
      if player == nil 
        next_board = spaces.dup
        next_board[space] = @game_piece
        depth += 1
        find_best_move(next_board, depth)
        rank = rank(next_board)
        if rank == 1
          #find board with depth of zero and update old board with that board      
        end
      end 
    end 
  end

  def rank(spaces)
    @rank ||= final_state_rank(spaces) || intermediate_state_rank(spaces)
  end

  def intermediate_state_rank(spaces)
    ranks = spaces.collect{ |game_state| game_state.rank }
    if @game.current_player == game_piece
      ranks.max
    else
      ranks.min
    end
  end 


  def final_state_rank(spaces)
    if @game_rules.game_over?(spaces).class == String
      return 0 if @game_rules.tie?(spaces)
      @game_rules.winner?(spaces) == @game_piece ? 1 : -1
    end
  end
end