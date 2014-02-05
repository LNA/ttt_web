require 'spec_helper'

describe GameTree do
  let (:game_tree) {GameTree.new}

  describe "#generate_all_possible_moves" do
    it "passes an initial game state to build_branches_for" do
      GameState.should_receive(:new).and_return("got it")
      game_tree.should_receive(:build_branches_for).with("got it")

      game_tree.generate_all_possible_moves
    end
  end
  
  describe "#build_branches_for(current_game_state)" do
    context "boards with no available moves" do  
      it "has an empty array of possible game states" do
        current_game_state = GameState.new('X', ['O', 'O', 'O',
                                                 'X', 'X', 'O',
                                                 'X', 'O', 'X'])

        game_tree.build_branches_for(current_game_state)
        current_game_state.possible_game_states.should == [] 
      end
    end

    context "boards with 1 available move" do
      it "builds branches for the correct player" do
        current_game_state = GameState.new('X', [nil, 'O', 'O',
                                                 'X', 'X', 'O',
                                                 'X', 'O', 'X'])

        game_tree.build_branches_for(current_game_state)
        current_game_state.possible_game_states.first.current_player.should == 'O'                                                             
      end

      it "has the correct board in it's possible_game_states" do
        current_game_state = GameState.new('X', [nil, 'O', 'O',
                                                 'X', 'X', 'O',
                                                 'X', 'O', 'X'])

        game_tree.build_branches_for(current_game_state)
        current_game_state.possible_game_states.first.board.should  == ['X', 'O', 'O',
                                                                        'X', 'X', 'O',
                                                                        'X', 'O', 'X']    
      end
    end

    context "boards with 2 available moves" do
      it "builds two branches for the next player" do
        current_game_state = GameState.new('X', [nil, nil, 'O',
                                                 'X', 'X', 'O',
                                                 'X', 'O', 'X'])
        
        game_tree.build_branches_for(current_game_state)
        current_game_state.possible_game_states.first.current_player.should == 'O'                                                             
        current_game_state.possible_game_states[1].current_player.should == 'O'                                                             
      end

      it "has the correct boards in it's possible_game_states" do 
        current_game_state = GameState.new('X', [nil, nil, 'O',
                                                 'X', 'X', 'O',
                                                 'X', 'O', 'X'])

        game_tree.build_branches_for(current_game_state)
        current_game_state.possible_game_states.first.board.should  == ['X', nil, 'O',
                                                                        'X', 'X', 'O',
                                                                        'X', 'O', 'X']    
        current_game_state.possible_game_states[1].board.should  ==    [nil, 'X', 'O',
                                                                        'X', 'X', 'O',
                                                                        'X', 'O', 'X']                                                                            
      end
    end

    context "boards with 3 available moves" do
      it "builds branches for the correct player" do
        current_game_state = GameState.new('X', [nil, nil, nil,
                                                 'X', 'X', 'O',
                                                 'X', 'O', 'X'])
       
        game_tree.build_branches_for(current_game_state)
        current_game_state.possible_game_states.each do |game_state|
          game_state.current_player.should == 'O'
        end     
      end

      it "builds the correct boards for the first branch of the game tree" do 
        current_game_state = GameState.new('X', [nil, nil, nil,
                                                 'X', 'X', 'O',
                                                 'X', 'O', 'X'])

        game_tree.build_branches_for(current_game_state)
        resulting_game_state = current_game_state.possible_game_states.first
        resulting_game_state.board.should  == ['X', nil, nil,
                                               'X', 'X', 'O',
                                               'X', 'O', 'X']
        resulting_game_state.possible_game_states.first.board.should == ['X', 'O', nil,
                                                                         'X', 'X', 'O',
                                                                         'X', 'O', 'X']
      end

      it "builds the correct boards for the last branch of the game tree" do
        current_game_state = GameState.new('X', [nil, nil, nil,
                                                 'X', 'X', 'O',
                                                 'X', 'O', 'X'])

        game_tree.build_branches_for(current_game_state)
        resulting_game_state = current_game_state.possible_game_states.last
        resulting_game_state.board.should  == [nil, nil, 'X',
                                               'X', 'X', 'O',
                                               'X', 'O', 'X']
        resulting_game_state.possible_game_states.last.board.should == [nil, 'O',   'X',
                                                                         'X', 'X', 'O',
                                                                         'X', 'O', 'X']
      end
    end
  end
end