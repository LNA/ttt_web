require 'spec_helper'
require 'mock_ui'
require 'mock_game_state'
require 'game_options'

describe 'GameOptions' do 

  let (:params) { {:player_one => '',
                   :player_two => ''      }}

  let (:game_options) {GameOptions.new(params)}

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

    it 'updates the player_two type' do
      game_options.update(:player_two => 'ai')

      game_options.player_two.should == 'ai'
    end
  end
end