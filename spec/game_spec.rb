require 'spec_helper'
require 'mock_ui'
require 'mock_game_state'


describe Game do 
  let (:ui) {MockUI.new}
  let (:game) {Game.new}
  let (:mock_ui) {MockUI.new}
  let (:mock_game_state) {MockGameState.new}
  let (:all_human_game) {game_options.update(:player_one => 'human', :player_two => 'human')}
  
  # before(:each) do
  #   @game = Game.new
  #   @mock_ui = MockUI.new
  #   @mock_game_state = MockGameState.new
  #   @game.ui = @mock_ui
  #   @game.game_state = @mock_game_state
  # end

  context '#set_player_types' do 
    it "updates player_one and player_two from game_options" do 
      game.game_options.update(:player_one => 'human')
      game.game_options.update(:player_two => 'ai')
     
      game.player_one = "human"
      game.player_two = "ai"
    end
  end
  
  context "#human_game_loop" do
    it "triggers ui ask for move message" do
      game.game_state = mock_game_state
      game.ui = mock_ui
      game.human_game_loop


      mock_ui.asked_for_move.should == true
    end

    it "gets a move from the ui" do
      @game.human_game_loop

      @mock_ui.provided_move.should == true
    end

    it "checks game state to see if move is valid" do
      @mock_ui.stored_moves = [0]
      
      @game.human_game_loop
      @mock_game_state.checked_move.should == true
    end
    
    it "finds the proper game state based of the players move" do
      @game.human_game_loop

      @mock_game_state.found_game_state.should == true
    end

    it "should trigger invalid move message if invalid" do
      @mock_ui.stored_moves = ["0", "1"]
      test_game_state = GameState.new('X', ['O', nil])
      @game.game_state = test_game_state
      @game.human_game_loop

      @mock_ui.invalid_message_sent.should == true
    end
  end

  context "#winner" do
    it "asks the game_state for the final state" do
      @game.winner

      @mock_game_state.checked_final_state.should == true
    end
  end

  context "#ai_game_loop" do
    it "plays the best ai move" do
      @game.ai_game_loop

      @mock_game_state.played_move.should == true
    end

    it "displays grid after AI move" do
      @game.ai_game_loop

      @mock_ui.displayed_updated_board.should == true
    end
  end 
end  