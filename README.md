# Tic Tac Toe in Ruby

## Objectives

1. Build a CLI Tic Tac Toe game!
2. Encapsulate Tic Tac Toe in a `TicTacToe` object.

## Overview

You're going to be building a 2 player CLI version of Tic Tac Toe by building a `TicTacToe` object. The game play will be very similar to other versions of TicTacToe.

<iframe width="100%" heigh="100%" src="https://www.youtube.com/embed/e4TMZ0f6qoI" frameborder="0" allowfullscreen></iframe>

## Instructions

**Run `bundle` within this lab's directory before getting started.**

### Project Structure

```bash
├── Gemfile
├── Gemfile.lock
├── README.md
├── Rakefile
├── bin
│   └── tictactoe
├── lib
│   └── tic_tac_toe.rb
└── spec
    ├── 01_tic_tac_toe_spec.rb
    ├── 02_play_spec.rb
    ├── 03_cli_spec.rb
    └── spec_helper.rb
```

#### Gemfile and Rakefile

These files setup some tools and gems for our project and can mostly be ignored. Make sure to run `bundle` before starting this project so that you have all the required gems.

#### `bin/tictactoe`

This is our main executable and will be how we run our game.

#### `lib/tic_tac_toe.rb`

Our main `TicTacToe` class will be defined here with all the data and logic required to play a game of tic tac toe via instances of `TicTacToe`.

#### `spec`

There are three test files that should be completed in order. `01_tic_tac_toe_spec.rb` sets tests for our helper methods within `TicTacToe`. `02_play_spec.rb` tests the main `#play` method. `03_cli_spec.rb` tests the CLI.

### Your Object Oriented Tic Tac Toe

We're going to be building a very well encapsulated object for Tic Tac Toe where each instance method will represent a discrete, single, responsibility or functionality of a Tic Tac Toe game.

We'll be following the Tic Tac Toe conventions of representing the board as an array with 9 elements where `" "` represents an empty cell in the board.

We'll be getting user input via `gets` and a player will choose a position by entering 1-9. Our program will then fill out the appropriate position on the board with the player's token.

We will keep track of which player's turn it is and how many turns have been played. We will check to see, at every turn, if there is a winner. If there is a winner, we'll congratulate them. If there is a tie, we will inform our players.

## Instructions

### `TicTacToe` class.

Open up `lib/tic_tac_toe.rb`. You'll be defining the main game class, `TicTacToe` in `lib/tic_tac_toe.rb`. Without that file defining a `TicTacToe` class, everything will break.

Every method you build will be encapsulated by this class.

### `#initialize` and `@board`

The first test in `01_tic_tac_toe_spec.rb` will ensure the requirement that when a new game of Tic Tac Toe is started, represented by initializing an instance of `TicTacToe`, the instance of the game must create the starting state of the board, an array with 9 `" "` empty strings, within an instance variable `@board`.

In other words, your `#initialize` method should set a `@board` variable equal to a new, empty, game board array.

#### `WIN_COMBINATIONS`

Define a constant in `lib/tic_tac_toe.rb`, `WIN_COMBINATIONS`, within the `TicTacToe` class and set it equal to a nested array filled with the index values for the various win combinations in tic tac toe.

**Top-Tip:** When you see this line, `TicTacToe::WIN_COMBINATIONS`, in the test suite, that means the test suite is accessing the constant `WIN_COMBINATIONS` that was declared inside the `TicTacToe` class.

```ruby
# within the body of TicTacToe

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5]  # Middle row
  # ETC, an array for each win combination
]

# the rest of the TicTacToe class definition
```

#### `#display_board`

Define a method that prints the current board representation based on the `@board` instance variable.

#### `#move`

Your `#move` method must take in two arguments, the location in the board array that the player chooses and the player's token (either "X" or "O"). The second argument, the player's token, should have a default of "X". Regarding the player's input: Remember that, from the player's point of view, the board contains spaces 1-9. But, an array's indeces start their count at 0. If the user's input is `5`, your method then must fill out the correct array element with the player's token. You'll have to account for that in your `#move` method.

#### `#position_taken?`

The `#position_taken?` method will be responsible for evaluating the user's input against the Tic Tac Toe board and checking to see whether or not that position is occupied. If the user inputs that they would like to fill out position `2`, our `#position_taken?` method will check to see if that position is vacant or if it contains an "X" or and "O". If the position is free, the method should return `false` (i.e. "not taken"), otherwise it will return `true`.

#### `#valid_move?`

Build a method `valid_move?` that accepts a position to check and returns `true` if the move is valid and `false` or `nil` if not. A valid move means that the submitted position is:

1. Present on the game board.
2. Not already filled with a token.

#### `#turn`

Build a method `#turn` to encapsulate the logic of a single complete turn composed of the following routine:

1. Asking the user for their move by position 1-9.
2. Receiving the user input.
3. If the move is valid, make the move.
4. If the move is invalid, ask for a new move until a valid move is received.
5. Display the board after the valid move has been made.

All these procedures will be wrapped into our `#turn` method. However, the majority of the logic for these procedures will be defined and encapsulated in individual methods which you've already built.

You can imagine the pseudocode for the `#turn` method:

```
ask for input
get input
if input is valid
  make the move for input
else
  ask for input again until you get a valid input
end
show the board
```

#### `#turn_count`

This method returns the number of turns that have been played based on the board in `@board`.

#### `#current_player`

The `#current_player` method should use the `#turn_count` method to determine if it is `"X"`'s turn or `"O"`'s.

#### `#won?`

Your `#won?` method should return false/nil if there is no win combination present in the board and return the winning combination indexes as an array if there is a win. Use your `WIN_COMBINATIONS` constant in this method.

#### `#full?`

The `#full?` method should return true if every element in the board contains either an "X" or an "O".

#### `#draw?`

Build a method `#draw?` that returns true if the board has not been won and is full and false if the board is not won and the board is not full, and false if the board is won.

#### `#over?`

Build a method `#over?` returns true if the board has been won, is a draw, or is full.

#### `#winner`

The `#winner` method should return the token, "X" or "O" that has won the game given a winning board.

### Putting it all together: the `#play` method

#### `#play`

The play method is the main method of the tic tac toe application and is responsible for the game loop. A tic tac toe game must allow players to take turns, checking if the game is over after every turn, and at the conclusion of the game, whether because it was won or because it was a draw, reporting to the user the outcome of the game. You can imagine the pseudocode:

```
until the game is over
  take turns
end

if the game was won
  congratulate the winner
else if the game was a draw
  tell the players it has been a draw
end
```

Run the tests for the `#play` method by typing `rspec spec/02_play_spec.rb` in your terminal.

### The CLI: `bin/tictactoe`

Your `bin/tictactoe` CLI should:

1. Instantiate an instance of `TicTacToe`
2. Start the game by calling `#play` on that instance.

<a href='https://learn.co/lessons/oo-tic-tac-toe' data-visibility='hidden'>View this lesson on Learn.co</a>
