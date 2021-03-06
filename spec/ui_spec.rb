require 'spec_helper'
require 'ui'

describe UI do 
  let (:ui) {UI.new}

  describe "#welcome_user" do
    it "sends a welcome message" do 
      STDOUT.should_receive(:puts).with("Welcome to ttt!")

      ui.welcome_user
    end
  end


  describe '#gets_player_type' do 
    it "gets the player_one type" do 
      ui.stub(:gets_player_type).and_return("H")

      ui.gets_player_type.should == "H"
    end
  end

  describe "#display_grid" do
    it "displays the grid" do
      board = ['X', 'O', 'X',
               nil, nil, nil,
               nil, nil, nil]
          
      STDOUT.should_receive(:puts).exactly(4).times.and_return(" X  O  X 
                                                                 3  4  5 
                                                                 6  7  8 ")
      ui.display_grid(board)
    end
  end

  describe "#ask_player_for_move" do
    it "prompts players move" do
      STDOUT.should_receive(:puts).with("Player one: Enter your move:")

      ui.ask_player_for_move("one")
    end
  end

  describe "#invalid_move_message" do
    it "displays an invalid move message" do
      STDOUT.should_receive(:puts).with("Sorry invalid move! Try again:")

      ui.invalid_move_message
    end
  end

  describe "#gets_move" do
    it "gets a move" do
    ui.stub(:gets).and_return("1") 

    ui.gets_move.should == "1"
  end

  describe "#winner_message" do
    it "displays the AI winning message" do
      STDOUT.should_receive(:puts).with("AI has won!")

      ui.winner_message('O')
    end

    it "displays a tie" do
      STDOUT.should_receive(:puts).with("Its a tie!")

      ui.winner_message(true)
    end
  end

  describe "#game_over"
    it "displays a game over message" do
      STDOUT.should_receive(:puts).with("Game Over!")

      ui.game_over
    end
  end
end