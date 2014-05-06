class Board
  attr_accessor :spaces, :open_spaces, :fill

  def initialize
    @spaces = [nil]*9
  end

  def fill(move, game_piece)
    @spaces[move.to_i] = game_piece
  end

  def open_spaces
   open_spaces =  @spaces.size.times.select {|i| @spaces[i] == nil}
  end
end
