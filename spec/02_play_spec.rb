require_relative '../lib/tic_tac_toe.rb'

describe './lib/tic_tac_toe.rb' do
  describe TicTacToe do
    describe '#play' do
      it 'asks for players input on a turn of the game' do
        game = TicTacToe.new
        allow($stdout).to receive(:puts)
        allow(game).to receive(:over?).and_return(false, true)

        expect(game).to receive(:gets).at_least(:once).and_return("1")

        game.play
      end

      it 'checks if the game is over after every turn' do
        game = TicTacToe.new
        allow($stdout).to receive(:puts)
        allow(game).to receive(:gets).and_return("1", "2", "3")

        expect(game).to receive(:over?).at_least(:twice).and_return(false, false, true)

        game.play
      end

      it 'plays the first turn of the game' do
        game = TicTacToe.new
        allow($stdout).to receive(:puts)
        allow(game).to receive(:gets).and_return("1")

        allow(game).to receive(:over?).and_return(false, true)

        game.play
        board_after_first_turn = game.instance_variable_get(:@board)
        expect(board_after_first_turn).to match_array(["X", " ", " ", " ", " ", " ", " ", " ", " "])
      end

      it 'plays the first few turns of the game' do
        game = TicTacToe.new

        allow($stdout).to receive(:puts)
        allow(game).to receive(:gets).and_return("1","2","3")
        allow(game).to receive(:over?).and_return(false, false, false, true)

        game.play

        board_after_three_turns = game.instance_variable_get(:@board)
        expect(board_after_three_turns).to match_array(["X", "O", "X", " ", " ", " ", " ", " ", " "])
      end

      it 'checks if the game is won after every turn' do
        game = TicTacToe.new
        allow($stdout).to receive(:puts)
        allow(game).to receive(:gets).and_return("1", "2", "3")
        allow(game).to receive(:winner).and_return("X")

        expect(game).to receive(:won?).at_least(:twice).and_return(false, false, true)

        game.play
      end

      it 'checks if the game is draw after every turn' do
        game = TicTacToe.new
        allow($stdout).to receive(:puts)
        allow(game).to receive(:gets).and_return("1", "2", "3")

        expect(game).to receive(:draw?).at_least(:twice).and_return(false, false, true)

        game.play
      end

      it 'stops playing if someone has won' do
        game = TicTacToe.new
        board = ["X", "X", "X", " ", " ", " ", " ", " ", " "]
        game.instance_variable_set(:@board, board)

        allow($stdout).to receive(:puts)

        expect(game).to_not receive(:turn)

        game.play
      end

      it 'congratulates the winner X' do
        game = TicTacToe.new
        board = ["X", "X", "X", " ", " ", " ", " ", " ", " "]
        game.instance_variable_set(:@board, board)
        allow($stdout).to receive(:puts)

        expect($stdout).to receive(:puts).with("Congratulations X!")

        game.play
      end

      it 'congratulates the winner O' do
        game = TicTacToe.new
        board = [" ", " ", " ", " ", " ", " ", "O", "O", "O"]
        game.instance_variable_set(:@board, board)

        allow($stdout).to receive(:puts)

        expect($stdout).to receive(:puts).with("Congratulations O!")

        game.play
      end

      it 'stops playing in a draw' do
        game = TicTacToe.new
        board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
        game.instance_variable_set(:@board, board)
        allow($stdout).to receive(:puts)

        expect(game).to_not receive(:turn)

        game.play
      end

      it 'prints "Cat\'s Game!" on a draw' do
        game = TicTacToe.new
        board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
        game.instance_variable_set(:@board, board)
        allow($stdout).to receive(:puts)

        expect($stdout).to receive(:puts).with("Cat's Game!")

        game.play
      end

      it 'plays through an entire game' do
        game = TicTacToe.new
        allow($stdout).to receive(:puts)

        expect(game).to receive(:gets).and_return("1")
        expect(game).to receive(:gets).and_return("2")
        expect(game).to receive(:gets).and_return("3")
        expect(game).to receive(:gets).and_return("4")
        expect(game).to receive(:gets).and_return("5")
        expect(game).to receive(:gets).and_return("6")
        expect(game).to receive(:gets).and_return("7")

        expect($stdout).to receive(:puts).with("Congratulations X!")

        game.play
      end
    end
  end
end
