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

  context '#set_player_type' do 
    it 'sets the player_one type from ui' do 
      game_options.set_player_type(player_one, player_two)

      game_options.player_one.should == 'H'
    end

    it 'sets the player_one type from ui' do 
      game_options.set_player_type(player_one, player_two)

      game_options.player_two.should == 'H'
    end
  end

  context '#set_player_two_type' do
    it 'sets the player_two type from the ui' do
      game_options.ui.stub(:gets_player_two_type).and_return("H")
      game_options.set_player_type(player_one, player_two)

      game_options.player_two.should == 'H'
    end
  end

  context '#set_game_type' do
    it 'sets the game type for a human versus human game' do
      game_options.player_one = 'H'
      game_options.player_two = 'H'

      game_options.set_game_type.should == 'human versus human'
    end

    it 'sets the game type for a human versus ai game' do
      game_options.player_one = 'H'
      game_options.player_two = 'a'

      game_options.set_game_type.should == 'human versus ai'
    end
  end
end