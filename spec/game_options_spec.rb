require 'spec_helper'
require 'mock_ui'
require 'game_options'

describe 'GameOptions' do 

  let (:params) { {:player_one => '',
                   :player_two => ''      }}

  let (:game_options) {GameOptions.new(params)}  
  let (:mock_ui) {MockUI.new}

  context '#iniailize' do
    it 'can set params for each player' do
      game_options.player_one.should == ''
      game_options.player_two.should == ''
    end
  end

  context '#update_player_one' do
    it 'updates the player_one type' do 
      game_options.update(:player_one => 'human')

      game_options.player_one.should == 'human'
    end
  end

  context '#update_two_one' do
    it 'updates the player_two type' do
      game_options.update(:player_two => 'ai')

      game_options.player_two.should == 'ai'
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
      require 'pry'
      binding.pry

      game_options.set_game_type.should == 'human versus human'
    end
  end
end