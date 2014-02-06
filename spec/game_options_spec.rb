require 'spec_helper'
require 'mock_ui'
require 'game_options'

describe 'GameOptions' do 

  let (:player_one) {'h'}
  let (:player_two) {'h'}

  let (:game_options) {GameOptions.new(player_one, player_two)}  
  let (:mock_ui) {MockUI.new}

  context '#iniailize' do
    it 'initializes with dependencies for each player' do
      game_options.player_one.should == 'h'
      game_options.player_two.should == 'h'
    end
  end

  context '#set_player_one_type' do 
    it 'sets the player_one type from ui' do 
      game_options.ui.stub(:gets_player_one_type).and_return("H")
      game_options.set_player_one_type

      game_options.player_one.should == 'human'
    end
  end

  context '#set_player_two_type' do
    it 'sets the player_two type from the ui' do
      game_options.ui.stub(:gets_player_two_type).and_return("H")
      game_options.set_player_two_type

      game_options.player_two.should == 'human'
    end
  end

  context '#set_game_type' do
    it 'sets the game type' do
      game_options.player_one = 'human'
      game_options.player_two = 'human'

      game_options.set_game_type.should == 'human versus human'
    end
  end
end