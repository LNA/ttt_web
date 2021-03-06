require 'spec_helper'

describe GameState do   
  let (:current_player) {'O'}
  let (:board) { [nil] * 9 }
  let (:game_state) {GameState.new(current_player, board)}
  let (:tie?) {['O', 'O', 'X', 'X', 'X', 'O', 'O', 'O', 'X']}
 
  context "#possible_game_states" do
    it "has a possible_game_states array" do
      game_state.possible_game_states.should == []
    end
  end

  context "#next_player" do 
    it "returns O if current_player is X" do
      game_state.current_player = 'X'
      game_state.next_player

      game_state.current_player.should == 'O'
    end

    it "returns X if current_player is O" do 
      game_state.next_player

      game_state.current_player.should == 'X'
    end
  end


  context "#valid(move)" do
    it "checks it's board for an invalid move" do 
      game_state.board[1] = 'X'
      move = 1

      game_state.valid(move).should == false
    end

    it "checks it's board for a valid move" do 
      move = 4

      game_state.valid(move).should == true
    end
  end

  context "#full_board? returns true when full" do
    it "returns true for a completed game" do
      game_state.board = ['X'] * 9
           
      game_state.full_board?.should == true
    end
  end

  context "#full_board? returns false" do
    it "returns false for an empty board" do
      game_state.board = [nil] * 9

      game_state.full_board?.should == false
    end

    it "returns false for a game with taken spaces" do 
      (1..9).each do |number|
        while number > 1
          number.times do
            game_state.board[number] = "X"
            number = number - 1
          end
        end
      end
    
      game_state.full_board?.should == false
    end
  end

  context "#game_state_for(move)" do
    it "returns the game state that matches the player move" do
      game_state.board = ['X', 'O', 'O', 
                         'X', 'X', 'O', 
                         'O', 'X', nil]
      move = 4
      game_state.possible_game_states = [game_state]

      game_state.game_state_for(move).should == game_state
    end
  end

  context "#rank" do
    context "boards with winners" do
      before :each do
        @game_state1 = GameState.new('O', ['X', 'O', 'O', 
                                           'X', 'O', 'X', 
                                           nil, 'O', 'O'])

        @game_state2 = GameState.new('O', ['X', 'O', 'O', 
                                           'X', 'X', 'X', 
                                           nil, 'O', 'O'])
      end

      it "ranks a 1 for a favorable 'O' game state" do
        game_state.possible_game_states = [@game_state1]
        game_state.rank.should == 1
      end

      it "ranks a -1 for a favorable 'X' game state" do
        game_state.possible_game_states = [@game_state2]
        game_state.rank.should == -1
      end
    end

    context "boards with a tie?" do
      it "ranks a 1 for a favorable 'O' game state" do
        game_state.board = tie?
        game_state.possible_game_states = [@game_state1]

        game_state.rank.should == 0
      end

      it "ranks a -1 for a favorable 'X' game state" do
        game_state.board = tie?
        game_state.possible_game_states = [@game_state1]

        game_state.rank.should == 0
      end
    end
  end

  context "#intermediate_state_rank" do
    context "boards with winners" do
      before :each do
        game_state1 = GameState.new('X', ['X', 'O', 'O', 
                                          'X', 'X', 'X', 
                                           nil, 'O', 'O'])

        game_state2 = GameState.new('O', ['O', 'O', 'O',
                                           'X', 'X', 'O',
                                           'X', 'O', 'X'])      
        game_state.possible_game_states = [game_state1, game_state2]
      end

      it "returns a rank for max" do
        game_state.intermediate_state_rank.should == 1
      end

      it "returns a rank for min" do
        game_state.current_player = 'X'

        game_state.intermediate_state_rank.should == -1
      end
    end
  
    context "boards with no winners" do
      it "it returns a 1 for a potential win within the intermediate state rank" do
        game_state1 = GameState.new('X', ['X', 'O', 'O', 
                                          'X', 'X', 'X', 
                                          nil, 'O', 'O',])

        game_state2 = GameState.new('O', ['O', 'O', 'O',
                                          'X', 'X', 'O',
                                          'X', 'O', 'X']) 
        game_state_in_progress1 = GameState.new('X', ['X', 'O',  'O', 
                                                       'X',  nil, 'X', 
                                                        nil, 'O', 'O'])

        game_state_in_progress2 = GameState.new('O', ['O',  'O', 'O', 
                                                       'X',  'X', 'O',
                                                        nil, 'O', nil])
        game_state.possible_game_states = [game_state_in_progress1, 
                                            game_state_in_progress2]
        game_state_in_progress1.possible_game_states = [game_state1, game_state2]
        game_state_in_progress2.possible_game_states = [game_state1, game_state2]
      

        game_state.intermediate_state_rank.should == 1
      end
    end
  end

  context "#final_state_rank" do
    it "has a final state rank of 1 in an 'O' win" do
      game_state.board = ['O'] * 9

      game_state.final_state_rank.should == 1
    end

    it "has a final state rank of 0 in a tie?" do
      game_state.board = tie?

      game_state.final_state_rank.should == 0
    end

    it "has a final state rank of -1 for an 'X' win" do
      game_state.board = ['X'] * 9

      game_state.final_state_rank.should == -1
    end

    it "returns nil if not in final state and there is no winner" do
      game_state.board = [nil] * 9

      game_state.final_state_rank.should == nil
    end
  end 

  context "#ai_play_best_move" do
    it "plays the best move" do
      game_state1 = GameState.new('O', ['X', 'O', 'O', 
                                        'X', 'X', 'O', 
                                        nil, 'O',  nil])

      game_state2 = GameState.new('O',  ['O', 'O', 'X',
                                         'X', 'X', 'O',
                                         nil, 'O', nil])

      game_state.possible_game_states = [game_state1, game_state2]

      game_state.ai_play_best_move.should == game_state1
    end
  end

  context "#winner" do
    context "boards with winners" do

      it "returns O as the winner for each row" do
        game_state.board[0..2] = 'A', 'B', 'C'
        game_state.board[3..5] = 'B', 'C', 'A'
        game_state.board[6..8] = 'A', 'B', 'C'

        [
          [0, 2],
          [3, 5],
          [6, 8]
        ].each do |low, high|
          game_state.board[low..high] = 'O', 'O', 'O'
          game_state.winner.should == 'O'
          game_state.board[low..high] = 'A', 'B', 'C'
        end
      end

      it "returs 'O' for a winner in the left column" do
        game_state = GameState.new('O', ['O', 'X', 'O', 
                                         'O', 'X', 'O', 
                                         'O', 'O', 'X'])
        game_state.winner.should == 'O'
      end

      it "returs 'O' for a winner in the middle column" do
        game_state = GameState.new('O', ['X', 'O', 'O', 
                                         'X', 'O', 'X', 
                                         'O', 'O', 'X'])
        game_state.winner.should == 'O'
      end

      it "returs 'O' for a winner in the right column" do
        game_state = GameState.new('O', ['X', 'O', 'O', 
                                         'X', 'X', 'O', 
                                         'O', 'X', 'O'])
        game_state.winner.should == 'O'
      end

      it "returs 'O' for a winner in the left diag" do
        game_state = GameState.new('O', ['O', 'X', 'O', 
                                         'X', 'O', 'X', 
                                         'O', 'X', 'O'])
        game_state.winner.should == 'O'
      end

      it "returs 'O' for a winner in the right diag" do
        game_state = GameState.new('O', ['X', 'X', 'O', 
                                         'X', 'O', 'X' ,
                                         'O', 'X', 'O'])
        game_state.winner.should == 'O'
      end

      it "returs false for a game in progress" do
        game_state = GameState.new('O', ['O', 'X', 'O', 
                                         'X', nil, 'X', 
                                         'O', 'X', 'O'])
        game_state.winner.should == false
      end

      it "returs false for a tie?" do
        game_state.board = tie?

        game_state.winner.should == false
      end
    end
  end

  context "#tie?" do 
    [
      [['O', 'O', 'X', 'X', 'X', 'O', 'O', 'O', 'X'], true],
      [[nil, nil, nil, nil, nil, nil, nil, nil, nil], false]
    ].each do |board, win|
      it "returns #{win} for the #{board}" do 
        game_state.board = board
        game_state.game_over?.should == win
      end
    end

    it "returns false for a game with open spaces" do 
      (1..9).each do |number|
        while number > 1
          number.times do
            game_state.board[number] = "X"
            number = number - 1
          end
        end
      end
    
      game_state.tie?.should == false
    end
  end

  context "#game_over?" do
    [
      [['O', 'O', 'X', 'X', 'X', 'O', 'O', 'O', 'X'], true],
      [['O', 'O', 'O', 'O', 'O', 'O', 'O', 'O', 'O'], 'O'],
      [['X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X'], 'X'],
      [[nil, nil, nil, nil, nil, nil, nil, nil, nil], false]
    ].each do |board, win|
      it "returns #{win} for the #{board}" do 
        game_state.board = board
        game_state.game_over?.should == win
      end
    end
  end
end