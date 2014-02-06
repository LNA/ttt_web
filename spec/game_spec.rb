require 'spec_helper'
require 'mock_ui'
require 'mock_game_state'
require 'ui'


describe Game do 
  let (:ui) {MockUI.new}
  let (:game_options) {GameOptions.new('human', 'human')}
  let (:game) {Game.new(ui, game_options, mock_game_state)}
  let (:mock_ui) {MockUI.new}
  let (:mock_game_state) {MockGameState.new}
  let (:all_human_game) {game_options.update(:player_one => 'human', :player_two => 'human')}

  
  context "#human_game_loop" do
    it "triggers ui ask for move message" do
      game.game_state = mock_game_state
      game.ui = mock_ui
      game.human_game_loop


      mock_ui.asked_for_move.should == true
    end

    it "gets a move from the ui" do
      game.game_state = mock_game_state
      game.ui = mock_ui
      game.human_game_loop

      mock_ui.provided_move.should == true
    end

    it "checks game state to see if move is valid" do
      mock_ui.stored_moves = [0]
      game.game_state = mock_game_state
      game.ui = mock_ui
      game.human_game_loop

      mock_game_state.checked_move.should == true
    end
    
    it "finds the proper game state based of the players move" do
      game.game_state = mock_game_state
      game.ui = mock_ui
      game.human_game_loop

      mock_game_state.found_game_state.should == true
    end

    # it "should trigger invalid move message if invalid" do
    #   mock_game_state = GameState.new('X', ['O', nil])
    #   game.game_state = mock_game_state
    #   game.ui = mock_ui.stored_moves = ["0", "1"]
    #    require 'pry'
    #   binding.pry
    #   game.human_game_loop

    #   mock_ui.invalid_message_sent.should == true
    # end
  end

  context "#winner" do
    it "asks the game_state for the final state" do
      game.game_state = mock_game_state
      game.ui = mock_ui
      game.winner

      mock_game_state.checked_final_state.should == true
    end
  end

  context "#ai_game_loop" do
    it "plays the best ai move" do
      game.game_state = mock_game_state
      game.ui = mock_ui
      game.ai_move

      mock_game_state.played_move.should == true
    end

    it "displays grid after AI move" do
      game.game_state = mock_game_state
      game.ui = mock_ui
      game.ai_move

      mock_ui.displayed_updated_board.should == true
    end
  end 
end  