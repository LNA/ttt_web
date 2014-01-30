require 'game_state'

describe GameState do   
  describe "#possible_game_states" do
    it "has a possible_game_states array" do
      @game_state = GameState.new(@current_player, @board)
      @game_state.possible_game_states.should == []
    end
  end

  describe "#valid" do
    before :each do
      @current_player = 'O'
      @board = ['X', 'O', 'O', 
                'X', nil, 'O', 
                'O', 'X', nil]
      @game_state = GameState.new(@current_player, @board)
    end

    it "checks it's board for an invalid move" do 
      move = 1
      @game_state.valid(move).should == false
    end

    it "checks it's board for a valid move" do 
      move = 4
      @game_state.valid(move).should == true
    end
  end

  describe "#full_board" do
    before :each do
      @current_player = 'O'
    end
    it "returns true for a completed game" do
      @board = ['O', 'O', 'O',
                'X', 'X', 'O',
                'X', 'O', 'X']
      @game_state = GameState.new(@current_player, @board)      
      @game_state.full_board.should == true
    end

    it "returns false for an empty board" do
      @game_state = GameState.new(@current_player, Array.new(9))
      @game_state.full_board.should == false
    end

    it "returns false for a game with 1 open space" do
      @board =  [nil, 'O',  'O',
                 'X',   'X',  'O',
                 'X',   'O',  'X']
      @game_state = GameState.new(@current_player, @board)
      @game_state.full_board.should == false
    end

    it "returns false for a game with 2 open space" do
      @board =  [nil, nil, 'O',
                 'X', 'X', 'O',
                 'X', 'O', 'X']
      @game_state = GameState.new(@current_player, @board)
      @game_state.full_board.should == false
    end

    it "returns false for a game with 3 open space" do
      @board =  [nil, nil, nil, 
                 'X', 'X', 'O',
                 'X', 'O', 'X']
      @game_state = GameState.new(@current_player, @board)
      @game_state.full_board.should == false
    end

    it "returns false for a game with 4 open space" do
      @board =  [nil, nil, nil, 
                 nil, 'X', 'O',
                 'X', 'O', 'X']
      @game_state = GameState.new(@current_player, @board)
      @game_state.full_board.should == false
    end

    it "returns false for a game with 5 open space" do
      @board =  [nil, nil, nil, 
                 nil, nil, 'O',
                 'X', 'O', 'X']
      @game_state = GameState.new(@current_player, @board)
      @game_state.full_board.should == false
    end

    it "returns false for a game with 6 open space" do
      @board =  [nil, nil, nil, 
                 nil, nil, nil, 
                 'X', 'O', 'X']
      @game_state = GameState.new(@current_player, @board)
      @game_state.full_board.should == false
    end

    it "returns false for a game with 7 open space" do
      @board =  [nil, nil, nil, 
                 nil, nil, nil, 
                 nil, 'O', 'X']
      @game_state = GameState.new(@current_player, @board)
      @game_state.full_board.should == false
    end

    it "returns false for a game with 8 open space" do
      @board =  [nil, nil, nil, 
                 nil, nil, nil, 
                 nil, nil, 'X']
      @game_state = GameState.new(@current_player, @board)
      @game_state.full_board.should == false
    end
  end

  describe "#game_state_for" do
    it "returns the game state that matches the player move" do
      @current_player = 'X'
      @board = ['X', 'O', 'O', 
                'X', nil, 'O', 
                'O', 'X', nil]
      @game_state = GameState.new(@current_player, @board)
      @game_state1 = GameState.new('X', ['X', 'O', 'O', 
                                         'X', 'O', 'O', 
                                         'O', 'X', nil])
      @game_state2 = GameState.new('X', ['X', 'O', 'O', 
                                         'X', 'X', 'O', 
                                         'O', 'X', nil])
      move = 4
      @game_state.possible_game_states = [@game_state1, @game_state2]
      @game_state.game_state_for(move).should == @game_state2
    end
  end

  describe "#rank" do
    context "boards with winners" do
      before :each do
        @game_state = GameState.new(@current_player, Array.new(9))
        @game_state1 = GameState.new('O', ['X', 'O', 'O', 
                                           'X', 'O', 'X', 
                                           nil, 'O', 'O'])

        @game_state2 = GameState.new('O', ['X', 'O', 'O', 
                                           'X', 'X', 'X', 
                                           nil, 'O', 'O'])
      end

      it "ranks a 1 for a favorable 'O' game state" do
        @game_state.possible_game_states = [@game_state1]
        @game_state.rank.should == 1
      end

      it "ranks a -1 for a favorable 'X' game state" do
        @game_state.possible_game_states = [@game_state2]
        @game_state.rank.should == -1
      end
    end

    context "boards with a tie" do
      before :each do
        @game_state = GameState.new(@current_player, Array.new(9))
        @game_state1 = GameState.new('O', ['X', 'O', 'O', 
                                           'O', 'X', 'X', 
                                           'O', 'X', 'O'])

        @game_state2 = GameState.new('O', ['X', 'O', 'X', 
                                           'O', 'O', 'X', 
                                           'O', 'X', 'O'])
      end

      it "ranks a 1 for a favorable 'O' game state" do
        @game_state.possible_game_states = [@game_state1, @game_state2]
        @game_state.rank.should == 0
      end

      it "ranks a -1 for a favorable 'X' game state" do
        @game_state.possible_game_states = [@game_state2]
        @game_state.rank.should == 0
      end
    end
  end

  describe "#intermediate_state_rank" do
    context "boards with winners" do
      before :each do
        @game_state = GameState.new('O', [])
        @game_state1 = GameState.new('X', ['X', 'O', 'O', 
                                           'X', 'X', 'X', 
                                           nil, 'O', 'O'])

        @game_state2 = GameState.new('O', ['O', 'O', 'O',
                                           'X', 'X', 'O',
                                           'X', 'O', 'X'])      
        @game_state.possible_game_states = [@game_state1, @game_state2]
      end

      it "returns a rank for max" do
        @game_state.intermediate_state_rank.should == 1
      end

      it "returns a rank for min" do
        @game_state.current_player = 'X'

        @game_state.intermediate_state_rank.should == -1
      end
    end
  
    context "boards with no winners" do
      before :each do 
        @game_state = GameState.new('O', [])
        @game_state1 = GameState.new('X', ['X', 'O', 'O', 
                                           'X', 'X', 'X', 
                                            nil, 'O', 'O',])

        @game_state2 = GameState.new('O', ['O', 'O', 'O',
                                           'X', 'X', 'O',
                                           'X', 'O', 'X']) 
        @game_state_in_progress1 = GameState.new('X', ['X', 'O',  'O', 
                                                       'X',  nil, 'X', 
                                                        nil, 'O', 'O'])

        @game_state_in_progress2 = GameState.new('O', ['O',  'O', 'O', 
                                                       'X',  'X', 'O',
                                                        nil, 'O', nil])
        @game_state.possible_game_states = [@game_state_in_progress1, 
                                            @game_state_in_progress2]
        @game_state_in_progress1.possible_game_states = [@game_state1, @game_state2]
        @game_state_in_progress2.possible_game_states = [@game_state1, @game_state2]
      end

      it "it returns a 1 for a potential win within the intermediate state rank" do
        @game_state.intermediate_state_rank.should == 1
      end
    end
  end

  describe "#final_state_rank" do
    it "has a final state rank of 1 in an 'O' win" do
      @board= ['X', 'O', 'O', 
               'X', 'X', 'O', 
               'O', 'X', 'O']
      @game_state = GameState.new(@current_player, @board)
      @game_state.final_state_rank.should == 1
    end

    it "has a final state rank of 0 in a tie" do
      @board = ['O', 'O', 'X', 
                'X', 'X', 'O', 
                'O', 'O', 'X']
      @game_state = GameState.new(@current_player, @board)
      @game_state.final_state_rank.should == 0
    end

    it "has a final state rank of -1 for an 'X' win" do
      @board = ['X', 'O', 'O', 
                'X', 'X', 'X', 
                'O', 'X', 'O']
      @game_state = GameState.new(@current_player, @board)
      @game_state.final_state_rank.should == -1
    end

    it "returns nil if not in final state and there is no winner" do
      @board = [nil, 'O', 'O', 
                'X', nil, 'X', 
                'O', 'X', 'O']
      @game_state = GameState.new(@current_player, @board)
      @game_state.final_state_rank.should == nil
    end
  end 


  describe "#ai_play_best_move" do
    it "plays the best move" do
      @game_state = GameState.new(@current_player, @board)
      @game_state1 = GameState.new('O', ['X', 'O', 'O', 
                                         'X', 'X', 'O', 
                                          nil,  'O',  nil])

      @game_state2 = GameState.new('O', ['O', 'O', 'X',
                                         'X', 'X', 'O',
                                          nil,  'O', nil])

      @game_state.possible_game_states = [@game_state1, @game_state2]

      @game_state.ai_play_best_move.should == @game_state1
    end
  end

  describe "#winner" do
    context "boards with winners" do
      it "returs 'O' for a winner in the first row" do
        @game_state = GameState.new('O', ['O', 'O', 'O', 
                                          'X', 'X', 'O', 
                                          nil, 'O', nil])
        @game_state.winner.should == 'O'
      end

      it "returs 'O' for a winner in the second row" do
        @game_state = GameState.new('O', ['O', 'X', 'O', 
                                          'O', 'O', 'O', 
                                          'X', 'O', 'X'])
        @game_state.winner.should == 'O'
      end

      it "returs 'O' for a winner in the third row" do
        @game_state = GameState.new('O', ['O', 'X', 'X', 
                                          'X', 'X', 'O', 
                                          'O', 'O', 'O'])
        @game_state.winner.should == 'O'
      end

      it "returs 'O' for a winner in the left column" do
        @game_state = GameState.new('O', ['O', 'X', 'O', 
                                          'O', 'X', 'O', 
                                          'O', 'O', 'X'])
        @game_state.winner.should == 'O'
      end

      it "returs 'O' for a winner in the middle column" do
        @game_state = GameState.new('O', ['X', 'O', 'O', 
                                          'X', 'O', 'X', 
                                          'O', 'O', 'X'])
        @game_state.winner.should == 'O'
      end

      it "returs 'O' for a winner in the right column" do
        @game_state = GameState.new('O', ['X', 'O', 'O', 
                                          'X', 'X', 'O', 
                                          'O', 'X', 'O'])
        @game_state.winner.should == 'O'
      end

      it "returs 'O' for a winner in the left diag" do
        @game_state = GameState.new('O', ['O', 'X', 'O', 
                                          'X', 'O', 'X', 
                                          'O', 'X', 'O'])
        @game_state.winner.should == 'O'
      end

      it "returs 'O' for a winner in the right diag" do
        @game_state = GameState.new('O', ['X', 'X', 'O', 
                                          'X', 'O', 'X' ,
                                          'O', 'X', 'O'])
        @game_state.winner.should == 'O'
      end

      it "returs false for a game in progress" do
        @game_state = GameState.new('O', ['O', 'X', 'O', 
                                          'X', nil, 'X', 
                                          'O', 'X', 'O'])
        @game_state.winner.should == false
      end

      it "returs false for a tie" do
        @game_state = GameState.new('O', ['O', 'O', 'X', 
                                          'X', 'X', 'O', 
                                          'O', 'O', 'X'])
        @game_state.winner.should == false
      end
    end
  end

  describe "#tie" do 
    before :each do
      @current_player = 'O'
    end
    it "returns true in the case of a tie" do
      @game_state = GameState.new('O', ['O', 'O', 'X', 
                                        'X', 'X', 'O', 
                                        'O', 'O', 'X'])
      @game_state.tie.should == true
    end

    it "returns false in the case of a win" do
      @game_state = GameState.new('O', ['O', 'O', 'X', 
                                        'X', 'X', 'X', 
                                        'O', 'O', 'X'])
      @game_state.tie.should == false
    end

    it "returns false in the case of a game with 1 open space" do
      @current_player = 'O'
      @board = ['O', 'O', 'X', 
                'X', nil, 'O', 
                'O', 'O', nil]
      @game_state = GameState.new(@current_player, @board)
      @game_state.tie.should == false
    end

    it "returns false for a game with 2 open space" do
      @board =  [nil, nil, 'O',
                 'X', 'X', 'O',
                 'X', 'O', 'X',]
      @game_state = GameState.new(@current_player, @board)
      @game_state.tie.should == false
    end

    it "returns false for a game with 3 open space" do
      @board =  [nil, nil, nil,
                 'X', 'X', 'O',
                 'X', 'O', 'X']
      @game_state = GameState.new(@current_player, @board)
      @game_state.full_board.should == false
    end

    it "returns false for a game with 4 open space" do
      @board =  [nil, nil, nil,
                nil, 'X', 'O',
                 'X', 'O', 'X']
      @game_state = GameState.new(@current_player, @board)
      @game_state.tie.should == false
    end

    it "returns false for a game with 5 open space" do
      @board =  [nil, nil, nil,
                 nil, nil,  'O',
                 'X', 'O', 'X']
      @game_state = GameState.new(@current_player, @board)
      @game_state.tie.should == false
    end

    it "returns false for a game with 6 open space" do
      @board =  [nil, nil, nil,
                 nil, nil, nil,
                 'X', 'O', 'X']
      @game_state = GameState.new(@current_player, @board)
      @game_state.tie.should == false
    end

    it "returns false for a game with 7 open space" do
      @board =  [nil, nil, nil,
                 nil, nil, nil,
                nil, 'O', 'X']
      @game_state = GameState.new(@current_player, @board)
      @game_state.tie.should == false
    end

    it "returns false for a game with 8 open space" do
      @board =  [nil, nil, nil,
                 nil, nil, nil,
                 nil, nil, 'X']
      @game_state = GameState.new(@current_player, @board)
      @game_state.tie.should == false
    end
  end

  describe "#game_over" do
    it "returns true in the case of a tie" do
      @game_state = GameState.new('O', ['O', 'O', 'X', 
                                        'X', 'X', 'O', 
                                        'O', 'O', 'X'])
      @game_state.game_over.should == true
    end

    it "returns 'O' in the case of an 'O' win" do
      @game_state = GameState.new('O', ['O', 'O', 'X', 
                                        'X', 'X', 'O', 
                                        'O', 'O', 'O'])
      @game_state.game_over.should == 'O'
    end

    it "returns 'X' in the case of an 'X' win" do
      @game_state = GameState.new('X', ['X', 'O', 'O', 
                                        'X', 'X', 'O', 
                                        'O', 'O', 'X'])
      @game_state.game_over.should == 'X'
    end

    it "returns false if there is no winner and no tie" do
      @game_state = GameState.new('X', ['X', 'O', 'O', 
                                        'X',  nil,  'O', 
                                        'O', 'O', 'X'])
      @game_state.game_over.should == false
    end
  end
end