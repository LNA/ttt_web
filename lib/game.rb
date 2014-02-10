
class Game
  attr_accessor :player_one, :player_two,
                :player_one_piece, :player_two_piece

  def initialize(params = {})
    @player_one_piece = player_one_piece
    @player_two_piece = player_two_piece
  end

  def update(params ={})
    @glass = params[:glass] unless params[:glass].nil?
    @mixer = params[:mixer] unless params[:mixer].nil?
  end         

  def either_player_is_ai(player_one, player_two)
    player_one == 'ai' || player_two == 'ai'
  end
end