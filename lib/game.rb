
class Game
  attr_accessor :player_one, :player_two,
                :player_one_piece, :player_two_piece

  def initialize(player_one_piece, player_two_piece)
    @player_one_piece = player_one_piece
    @player_two_piece = player_two_piece
  end
                

  def either_player_is_ai(player_one, player_two)
    player_one == 'ai' || player_two == 'ai'
  end
end