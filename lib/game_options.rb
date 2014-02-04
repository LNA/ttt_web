require 'ui'
require 'game_tree'
require 'game_state'

class GameOptions
  attr_accessor :player_one, :player_two

  def initialize(params = {})
    @player_one = params[:player_one]
    @player_two = params[:player_two]
  end

  def update(params = {})
    @player_one = params[:player_one] unless params[:player_one].nil?
    @player_two = params[:player_two] unless params[:player_two].nil?
  end

end