require 'ai'
require 'board'
require 'game_rules'

describe AI do
  let (:game_rules) {GameRules.new}
  let (:board)      {Board.new}

  before :each do
    @ai = AI.new(game_rules, 'O', 'X')
  end

  context 'score #possible_moves' do 
    # it 'stores scores for possible moves' do
    #   board.spaces = [nil]*9
    #   @ai.find_best_move(board)
    #   @ai.possible_moves.should == {0 => AI::IN_PROGRESS_SCORE,
    #                                 1 => AI::IN_PROGRESS_SCORE,
    #                                 2 => AI::IN_PROGRESS_SCORE,
    #                                 3 => AI::IN_PROGRESS_SCORE,
    #                                 4 => AI::IN_PROGRESS_SCORE,
    #                                 5 => AI::IN_PROGRESS_SCORE,
    #                                 6 => AI::IN_PROGRESS_SCORE,
    #                                 7 => AI::IN_PROGRESS_SCORE,
    #                                 8 => AI::IN_PROGRESS_SCORE}
    # end

    it 'stores the score for a possible win' do
      board.spaces = ['O', 'O', nil,
                      nil, nil, nil,
                      nil, nil, nil]

      @ai.find_best_move(board)
      @ai.possible_moves[2].should == AI::WIN - 2
    end

    it 'stores the score for a possible loss' do 
      board.spaces = ['X', 'X', 'X',
                      nil, nil, nil,
                      nil, nil, nil]
      @ai.find_best_move(board)
      @ai.possible_moves[3].should == (AI::LOSS + 2).abs
    end

    it 'finds the best move when the best score is 500' do 
      @ai.possible_moves = {1=>500, 2=>0, 3=>-500, 4=>100}
      @ai.best_move.should == 1
    end

    it 'finds the best move when the best score is a loss' do 
      @ai.possible_moves = {1=>-497, 2=>494}
      @ai.best_move.should == 1
    end
  end

  context '#find_best_move' do 
    it 'returns the best possible move on a board with 9 open spaces' do 
      board.spaces = [nil, nil, nil,
                      nil, nil, nil,
                      nil, nil, nil]

      acceptable_moves = [0, 2, 6, 8]
      move = @ai.find_best_move(board)

      acceptable_moves.should include(move)
    end
  end

  context '#add_best_possible_move' do 
    it 'replaces a score for a move if the current score is less than the previous score' do
     @ai.possible_moves = {1=>500, 2=>0, 3=>-500, 4=> 100}
     score = 0
     move = 1
     @ai.track_best(move, score).should == {1=>500, 2=>0, 3=>-500, 4=> 100}
   end
  end

  context '#rank' do
    it 'scores an in progress game' do
      board.spaces = [nil] * 9
      depth = 1
      @ai.rank(board.spaces, depth).should == AI::IN_PROGRESS_SCORE
    end

    it 'scores a win in one move for the ai' do
      board.spaces = [nil] * 9
      board.spaces[0] = 'O'
      board.spaces[1] = 'O'
      board.spaces[2] = 'O'

      depth = 1
      @ai.rank(board.spaces, depth).should == AI::WIN - 1
    end

    it 'scores a win in one move for the ai if the piece is X' do
      @ai.game_piece = 'X'
      board.spaces = [nil] * 9
      board.spaces[0] = 'X'
      board.spaces[1] = 'X'
      board.spaces[2] = 'X'

      depth = 1
      @ai.rank(board.spaces, depth).should == AI::WIN - 1
    end

    it 'scores a win in one move for the opponent' do
      @ai.game_piece = 'X'
      @ai.opponent_piece = 'O'
      board.spaces = [nil] * 9
      board.spaces[0] = 'O'
      board.spaces[1] = 'O'
      board.spaces[2] = 'O'

      depth = 1
      @ai.rank(board.spaces, depth).should == AI::LOSS + 1
    end
  end
end