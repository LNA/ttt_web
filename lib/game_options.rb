class GameOptions
  attr_accessor :player_one, :player_two, :ui

  def initialize(params = {})
    @player_one = params[:player_one]
    @player_two = params[:player_two]
    @ui = UI.new
  end

  def update(params = {})
    @player_one = params[:player_one] unless params[:player_one].nil?
    @player_two = params[:player_two] unless params[:player_two].nil?
  end

  def set_player_two_type
    player_two = @ui.gets_player_two_type
    if player_two.upcase == "H"
      self.update(:player_two => 'human')
    else
      self.update(:player_two => 'ai')
    end
  end
end