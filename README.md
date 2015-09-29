# Tic Tac Toe in Ruby

## Objectives

1. Build a CLI Tic Tac Toe game!
2. Encapsulate Tic Tac Toe in a `TicTacToe` object.

## Overview

You're going to be building a 2 player CLI version of Tic Tac Toe by building a `TicTacToe` object. The game play with be very similar to other versions of TicTacToe.

<iframe width="100%" heigh="100%" src="https://www.youtube.com/embed/e4TMZ0f6qoI" frameborder="0" allowfullscreen></iframe>

### Project Structure

```
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

We're going to be building a very well encapsulated object for Tic Tac Toe where each instance method will be a discrete, single, responsibility or functionality of a Tic Tac Toe game.

We'll be following the Tic Tac Toe conventions of representing the board as an array with 9 elements where `" "` represents an empty cell in the board.

We'll be getting user input via `gets` and a player will choose a position by entering 1-9. Our program will then fill out the appropriate position on the board with the player's token.

We will keep track of which player's turn it is and how many turns have been played. We will check to see, at every turn, if there is a winner. If there is a winner, we'll congratulate them. If there is a tie, we will inform our players.

## Instructions

### `TicTacToe` class.

Open up `lib/tic_tac_toe.rb`. You'll be defining the main game class, `TicTacToe` in `lib/tic_tac_toe.rb`. Without that file defining a `TicTacToe` class, everything will break.

Every method you build will be encapsulated by this class.

### `#initialize` and `@board`

The first test in `01_tic_tac_toe_spec.rb` will ensure the requirement that when a new game of Tic Tac Toe is started, represented by initializing an instance of `TicTacToe`, the instance of the game must create the starting state of the board, an array with 9 `" "` empty strings, within an instance variable `@board`

#### `WIN_COMBINATIONS`

Define a constant in `lib/tic_tac_toe.rb` `WIN_COMBINATIONS` within the `TicTacToe` class and set it equal to a nested array filled with the index values for the various win combinations in tic tac toe. That constant can be referred to globally as `TicTacToe::WIN_COMBINATIONS`

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

An empty board would be:

```ruby
board = [" "," "," "," "," "," "," "," "," "]
display_board(board)
```
Outputting:

```
   |   |   
-----------
   |   |   
-----------
   |   |   
```

A board with an "X" in the middle:
```ruby
board = [" ", " ", " ", " ", "X", " ", " ", " ", " "]
display_board(board)
```
Outputting:

```
   |   |   
-----------
   | X |   
-----------
   |   |   
```

#### `#move`

Your `#move` method must take in three arguments, the board array, the location in the board array that the player would like to fill out with an "X" or and "O", and the player's character (either "X" or "O"). The third argument, the player's character, should have a default of "X". Regarding the player's input: if the user's input is `5`, the player wants to fill out position 5 with their character. This means that your method must fill out the correct array index with the player's character. Remember that, from the player's point of view, the board contains spaces 1-9. But, an array's indexes start their count at 0. You'll have to account for that in your `#move` method.

#### `#position_taken?`

The `#position_taken?` method will be responsible for evaluating the user's input against the Tic Tac Toe board and checking to see whether or not that position is occupied. If the user inputs that they would like to fill out position `2`, our `#position_taken?` method will check to see if that position is vacant or if it contains an "X" or and "O". If the position is free, the method should return `false` (i.e. "not taken"), otherwise it will return `true`.

#### `#valid_move?`

Build a method `valid_move?` that accepts a board and a position to check and returns `true` if the move is valid and `false` or `nil` if not. A valid move means that the submitted position is:

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

This method takes in an argument of the board array and returns the number of turns that have been played.

#### `#current_player`

The `#current_player` method should take in an argument of the game board and use the `#turn_count` method to determine if it is `"X"`'s turn or `"O"`'s.

#### `#won?`

Your `#won?` method should accept a board as an argument and return false/nil if there is no win combination present in the board and return the winning combination indexes as an array if there is a win. Use your `WIN_COMBINATIONS` constant in this method.

#### `#full?`

The `#full?` method should accept a board and return true if every element in the board contains either an "X" or an "O".

#### `#draw?`

Build a method `#draw?` that accepts a board and returns true if the board has not been won and is full and false if the board is not won and the board is not full, and false if the board is won.

#### `#over?`

Build a method `#over?` that accepts a board and returns true if the board has been won, is a draw, or is full.

#### `#winner`

The `#winner` method should accept a board and return the token, "X" or "O" that has won the game given a winning board.

### Putting it all together: the `#play` method

#### `#play`

The play method is the main method of the tic tac toe application and is responsible for the game loop. A tic tac toe game must allow players to tale turns, checking if the game is over after every turn, and at the conclusion of the game, whether because it was won or because it was a draw, reporting to the user the outcome of the game. You can imagine the psuedocode:

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

#### Reading the `#play` test specs and output

It'll help you a bit to understand how the tests are written for `#play` and what the failure output means. Open up `spec/02_play_spec.rb`. You'll see the first test block:

```ruby
it 'asks for players input on a turn of the game' do
  board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  allow($stdout).to receive(:puts)
  allow(self).to receive(:over?).and_return(false, true)

  expect(self).to receive(:gets).at_least(:once).and_return("1")

  play(board)
end
```

This test is built to confirm that your implementation of the `#play` method will at some point ask the user for input via the `gets` method. In order to ensure this requirement of the play method, our test needs to setup some conditions and expectations.

1 . First, we have a sample game board, `board`, as it would look at the start of the game, entirely empty.

```ruby
board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
```

2 . We state that any output to `$stdout` (which is how Ruby sends output to your terminal) should basically be ignored. Otherwise when we run our tests, we'll see all of our programs output and it'll be super confusing.

```ruby
allow($stdout).to receive(:puts)
```

3 . Our play method is going to involve looping. The test suite is going to ensure that when you build your game loop, you use the `#over?` method as a condition of when to end the loop. When we call `#play` in our test this loop will never end because there is no player input and no one ever wins the game in most of our tests. This would create an infinite loop in our test. So to avoid this, we fake the behavoir of `#over?`, making sure it returns false the first time it is called and true the second.

```ruby
allow(self).to receive(:over?).and_return(false, true)
```

In this test it is as though the `#over?` method was defined to automatically return `false` the first time it is called and `true` all other times. Because the `#play` loop depends on `#over?`, when `#over?` returns true, the loop should end.

In our tests, we can stub the functionality of any method to behave exactly as we would like for this test to function and create the conditions that allow us to specify functionality. This technique of faking or hardcoding the return value and behavior of a method is called Mocking or Stubbing. It's a bit of an advanced technique in testing and for the most part, you don't need to worry about it.

4 . The main expectation of our test is that when `#play` is called, at some point the user will be prompted for input via the `gets` method. We set exactly this expectation:

```ruby
expect(self).to receive(:gets).at_least(:once).and_return("1")
```

The final bit of that, `and_return("1")`, states that when `gets` is called and the expectation is met, the call to `gets` should also be stubbed and return "1".

5 . Finally, after setting up the expectations of the behavoir of `#play`, the test suite evokes the method. All expectations set must be met by the termination of that method call.

```ruby
play(board)
```


With a non-functioning `#play` method, let's look at the output of the failure.

```ruby
def play(board)
end
```

If we ran the test suite against that code in `lib/tic_tac_toe.rb`, we'd see.

```
1) ./lib/tic_tac_toe.rb #play asks for players input on a turn of the game
     Failure/Error: expect(self).to receive(:gets).at_least(:once).and_return("1")
       (#<RSpec::ExampleGroups::LibTicTacToeRb::Play:0x007fdafb0dea20>).gets(*(any args))
           expected: at least 1 time with any arguments
           received: 0 times with any arguments
     # ./spec/02_play_spec.rb:10:in `block (3 levels) in <top (required)>'
```

The key output is the failed expectation.

```
Failure/Error: expect(self).to receive(:gets).at_least(:once).and_return("1")
  expected: at least 1 time with any arguments
  received: 0 times with any arguments
```

The test is saying that during the call to `#play`, we expected the program to call `gets`, but it didn't. Let's fix this simply by updating the definition of `#play`.

```ruby
def play(board)
  input = gets
end
```

```
./lib/tic_tac_toe.rb
  #play
    asks for players input on a turn of the game

Finished in 0.0058 seconds (files took 0.1434 seconds to load)
1 example, 0 failures
```

And it works! We don't want to just use that, the `#play` method is way more complicated and probably shouldn't be calling `gets` itself but rather having some other method, like `#turn` call gets. As long as something `#play` does meets the expectations set, the test will pass.

### The CLI: `bin/tictactoe`

Your `bin/tictactoe` CLI should:

1. Greet the players with "Welcome to Tic Tac Toe!"
2. Define a `board` array.
3. Display the starting board.
4. Begin the game by calling `#play`.

#### Top-Tip: Using a Console

When building a large application like this one, it's useful to be able to explore your code through an interactive console that has all your code loaded. For example, imagine wanting to test your `#valid_move?` method. You might have built the method in `lib/tic_tac_toe.rb`, but besides finishing the entire lab and trying it in the context of your CLI or running the test suite and seeing output, it's very hard to know how the method you built behaves. So you might start `irb` in your terminal and copy the source of your `#valid_move` method into a new IRB session so you can play with it. But as the methods become more complex and dependent, that breaks down. So we've given you a console that will load your code for you into a sort of interactive playground.

First, run `bundle` to make sure all your gems are installed. Then, you can start the console with `rake console` in your terminal.

Imagine your `lib/tic_tac_toe.rb` containing:

```ruby
def move(board, location, player = "X")
  board[location.to_i-1] = player
end
```

If you run `rake console`, you'll see.

```
$ rake console
Loading your application environment...
Console started:
[1] pry(main)>
```

At your prompt, you can execute ruby just like you could in an IRB session. The only difference is that your console has already read all the code in your application, so you have access to it in this Pry session.

```
$ rake console
Loading your application environment...
Console started:
[1] pry(main)> board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
=> [" ", " ", " ", " ", " ", " ", " ", " ", " "]
[2] pry(main)> valid_move?(board, "1")
=> true
[3] pry(main)> board = ["X", " ", " ", " ", " ", " ", " ", " ", " "]
=> ["X", " ", " ", " ", " ", " ", " ", " ", " "]
[4] pry(main)> valid_move?(board, "1")
=> false
```

As you can see, it's easy to test the method with data we created.

## Code Coverage

Included with this lesson is a tool that will generate a Coverage Report that shows how much of our code is tested when we run our tests. After a test run, you can open the file generated in `coverage/index.html` from terminal with `open coverage/index.html`. It should pop up in your browser and look like:

![Coverage](https://dl.dropboxusercontent.com/s/59peed056jjk9xm/2015-09-20%20at%203.39%20PM.png)

When you click on `lib/tic_tac_toe.rb`, you'll see something like:

![Coverage 2](https://dl.dropboxusercontent.com/s/3xzof85jm0g5vwp/2015-09-20%20at%203.40%20PM.png)

The lines in green have been tested, the lines in red haven't. When all tests pass, you should see 100% test coverage.
