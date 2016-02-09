require_relative '../lib/tic_tac_toe.rb'

describe './lib/tic_tac_toe.rb' do
  describe TicTacToe do
    describe '#initialize' do
      it 'assigns an instance variable @board to an array with 9 blank spaces " "' do
        game = TicTacToe.new
        expect(game.instance_variable_get(:@board)).to eq([" "," "," "," "," "," "," "," "," "])
      end
    end

    describe '#display_board' do
      it 'prints arbitrary arrangements of the board' do
        board = ["X", "X", "X", "X", "O", "O", "X", "O", "O"]
        game = TicTacToe.new
        game.instance_variable_set(:@board, board)

        output = capture_puts{ game.display_board }

        expect(output).to include(" X | X | X ")
        expect(output).to include("-----------")
        expect(output).to include(" X | O | O ")
        expect(output).to include("-----------")
        expect(output).to include(" X | O | O ")


        board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
        game.instance_variable_set(:@board, board)

        output = capture_puts{ game.display_board }

        expect(output).to include(" X | O | X ")
        expect(output).to include("-----------")
        expect(output).to include(" O | X | X ")
        expect(output).to include("-----------")
        expect(output).to include(" O | X | O ")
      end
    end

    describe 'WIN_COMBINATIONS' do
      it 'defines a constant WIN_COMBINATIONS with arrays for each win combination' do
        expect(TicTacToe::WIN_COMBINATIONS.size).to eq(8)

        expect(TicTacToe::WIN_COMBINATIONS).to include([0,1,2]).or include([2,1,0])
        expect(TicTacToe::WIN_COMBINATIONS).to include([3,4,5]).or include([5,4,3])
        expect(TicTacToe::WIN_COMBINATIONS).to include([6,7,8]).or include([8,7,6])
        expect(TicTacToe::WIN_COMBINATIONS).to include([0,3,6]).or include([6,3,0])
        expect(TicTacToe::WIN_COMBINATIONS).to include([1,4,7]).or include([7,4,1])
        expect(TicTacToe::WIN_COMBINATIONS).to include([2,5,8]).or include([8,5,2])
        expect(TicTacToe::WIN_COMBINATIONS).to include([0,4,8]).or include([8,4,0])
        expect(TicTacToe::WIN_COMBINATIONS).to include([6,4,2]).or include([2,4,6])
      end
    end

    describe '#move' do
      it 'allows "X" player in the top left and "O" in the middle' do
        game = TicTacToe.new
        game.move(1, "X")
        game.move(5, "O")

        board = game.instance_variable_get(:@board)

        expect(board).to eq(["X", " ", " ", " ", "O", " ", " ", " ", " "])
      end
    end

    describe '#position_taken?' do
      it 'returns true/false based on position in board' do
        game = TicTacToe.new
        board = ["X", " ", " ", " ", " ", " ", " ", " ", "O"]
        game.instance_variable_set(:@board, board)

        index = 0
        expect(game.position_taken?(index)).to be(true)

        index = 8
        expect(game.position_taken?(index)).to be(true)

        index = 1
        expect(game.position_taken?(index)).to be(false)

        index = 7
        expect(game.position_taken?(index)).to be(false)
      end
    end

    describe '#valid_move?' do
      it 'returns true/false based on position' do
        game = TicTacToe.new
        board = [" ", " ", " ", " ", "X", " ", " ", " ", " "]
        game.instance_variable_set(:@board, board)

        position = "1"
        expect(game.valid_move?(position)).to be_truthy

        position = "5"
        expect(game.valid_move?(position)).to be_falsey

        position = "invalid"
        expect(game.valid_move?(position)).to be_falsey
      end
    end

    describe '#turn' do
      it 'makes valid moves' do
        game = TicTacToe.new
        allow($stdout).to receive(:puts)

        expect(game).to receive(:gets).and_return("1")

        game.turn
      end

      it 'asks for input again after a failed validation' do
        game = TicTacToe.new
        allow($stdout).to receive(:puts)

        expect(game).to receive(:gets).and_return("invalid")
        expect(game).to receive(:gets).and_return("1")

        game.turn
      end
    end

    describe '#turn_count' do
      it 'counts occupied positions' do
        game = TicTacToe.new
        board = ["O", " ", " ", " ", "X", " ", " ", " ", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.turn_count).to eq(3)
      end
    end

    describe '#current_player' do
      it 'returns the correct player, X, for the third move' do
        game = TicTacToe.new
        board = ["O", " ", " ", " ", "X", " ", " ", " ", " "]
        game.instance_variable_set(:@board, board)

        expect(game.current_player).to eq("X")
      end
    end

    describe "#won?" do
      it 'returns false for a draw' do
        game = TicTacToe.new
        board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
        game.instance_variable_set(:@board, board)

        expect(game.won?).to be_falsey
      end

      it 'returns true for a win' do
        game = TicTacToe.new
        board = ["X", "O", "X", "O", "X", "X", "O", "O", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.won?).to be_truthy
      end
    end

    describe '#full?' do
      it 'returns true for a draw' do
        game = TicTacToe.new
        board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
        game.instance_variable_set(:@board, board)

        expect(game.full?).to be_truthy
      end

      it 'returns false for an in-progress game' do
        game = TicTacToe.new
        board = ["X", " ", "X", " ", "X", " ", "O", "O", " "]
        game.instance_variable_set(:@board, board)

        expect(game.full?).to be_falsey
      end
    end

    describe '#draw?' do
      it 'returns true for a draw' do
        game = TicTacToe.new
        board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
        game.instance_variable_set(:@board, board)

        expect(game.draw?).to be_truthy
      end

      it 'returns false for a won game' do
        game = TicTacToe.new
        board = ["X", "O", "X", "O", "X", "X", "O", "O", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.draw?).to be_falsey
      end

      it 'returns false for an in-progress game' do
        game = TicTacToe.new
        board = ["X", " ", "X", " ", "X", " ", "O", "O", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.draw?).to be_falsey
      end
    end

    describe '#over?' do
      it 'returns true for a draw' do
        game = TicTacToe.new
        board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
        game.instance_variable_set(:@board, board)

        expect(game.over?).to be_truthy
      end

      it 'returns true for a won game' do
        game = TicTacToe.new
        board = ["X", "O", "X", "O", "X", "X", "O", "O", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.over?).to be_truthy
      end

      it 'returns false for an in-progress game' do
        game = TicTacToe.new
        board = ["X", " ", "X", " ", "X", " ", "O", "O", " "]
        game.instance_variable_set(:@board, board)

        expect(game.over?).to be_falsey
      end
    end

    describe '#winner' do
      it 'return X when X won' do
        game = TicTacToe.new
        board = ["X", " ", " ", " ", "X", " ", " ", " ", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.winner).to eq("X")
      end

      it 'returns O when O won' do
        game = TicTacToe.new
        board = ["X", "O", " ", " ", "O", " ", " ", "O", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.winner).to eq("O")
      end

      it 'returns nil when no winner' do
        game = TicTacToe.new
        board = ["X", "O", " ", " ", " ", " ", " ", "O", "X"]
        game.instance_variable_set(:@board, board)

        expect(game.winner).to be_nil
      end
    end
  end
end
