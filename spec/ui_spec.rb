require 'spec_helper'

describe UI do 
  let (:ui) {UI.new}

  context "#welcome_user" do
    it "sends a welcome message" do 
      STDOUT.should_receive(:puts).with("Welcome to ttt!")

      ui.welcome_user
    end
  end

  context '#get_player_type_for' do 
    it "gets the player_one type" do 
      ui.stub(:gets_player_type_for).and_return("H")

      ui.gets_player_type_for.should == "H"
    end
  end

  context '#gets_player_game_piece' do 
    it "gets the player game piece" do
      ui.stub(:gets_player_game_piece).and_return("Z")

      ui.gets_player_game_piece.should == "Z"
    end
  end

  context "#display_grid" do
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

  context "#ask_player_for_move" do
    it "prompts players move" do
      STDOUT.should_receive(:puts).with("Enter your move:")

      ui.ask_player_for_move
    end
  end

  context "#invalid_move_message" do
    it "displays an invalid move message" do
      STDOUT.should_receive(:puts).with("Sorry invalid move! Try again:")

      ui.invalid_move_message
    end
  end

  context "#gets_move" do
    it "gets a move" do
    ui.stub(:gets).and_return("1") 

    ui.gets_move.should == "1"
  end

  context "#winner_message" do
    it "displays the AI winning message" do
      STDOUT.should_receive(:puts).with("O has won!")

      ui.winner_message('O')
    end

    it "#tie_message" do
      STDOUT.should_receive(:puts).with("Its a tie!")

      ui.tie_message
    end
  end

  context "#game_over"
    it "displays a game over message" do
      STDOUT.should_receive(:puts).with("Game Over!")

      ui.game_over
    end
  end
end