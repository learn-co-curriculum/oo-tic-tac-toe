require 'pry'
class TicTacToe
    def initialize
        @board = Array.new(9, " ")
    end
    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2]
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        # binding.pry
        input.to_i - 1
    end

    def move(index, token = "X")
        @board[index] = token
    end

    def position_taken?(index)
        if @board[index] == "X" || @board[index] == "O"
            true
        else
            false
        end
    end

    def valid_move?(index)
        !position_taken?(index) && index.between?(0, 8)
    end

    def turn_count
        @board.count {|x| x == "X" || x == "O"}
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end

    def turn
        puts "Please enter a number from (1-9): "
        user_input = gets.strip
        choice = input_to_index(user_input)
        if valid_move?(choice)
            move(choice, current_player)
        else
            turn
        end
        display_board
    end

    def won?
        WIN_COMBINATIONS.any? do |combo|
            if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
                return combo
            end
        end
    end

    def full?
        @board.all?{|square| square != " " }
    end

    def draw?
        full? && !won?
    end
    
    def over?
        won? || draw?
    end
    
    def winner
        if combo = won?
          @board[combo[0]]
        end
    end
    
    def play
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end
end
