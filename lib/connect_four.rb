# lib/connect_four.rb

require 'pry-byebug'

# Notes
# Connect Four board is 7 columns x 6 rows
# Use unicode to display black or white checkers
# use TDD-friendly game design from ruby_exercises 13-15
# user input is only a column number (1-7)

class ConnectFourGame

  def initialize(row = 6, col = 7)
    @board = Array.new(row) { Array.new(col) }
    @active_player = 1
    # @player1_checker = 
    # @player2_checker =

    @player1_input = nil
    @player2_input = nil

    # for IRB @board = Array.new(6) { Array.new(7) }
  end

  # method stub
  def play_game
    puts 'Game instructions'
    turn_order until game_over? # this doesn't work, has to wait for both players to finish before ending game
    puts 'Final message'
  end

  # Number of players (2) is hard coded
  def turn_order

    player_turn(@active_player)


    
    # switch between player 1 and player 2
    if @active_player == 1
      @active_player = 2
    else
      @active_player = 1
    end

  end

  # Is it easy to read this method and understand what is happening?
  def player_turn(player_num)
    loop do
      verified_col = verify_input(player_input(player_num))

      # even if verified_col is nil, the loop will repeat until a valid input is entered
      if player_num == 1
        @player1_input = verified_col
      else
        @player2_input = verified_col
      end

      break if verified_col # break if not nil

      puts 'Input Error!'
    end
  end

  # Accept player input
  def player_input(player_num)
    puts "Player #{player_num} enter move: "
    gets.chomp
  end

  # Basic player move method. Need a basic method in place before adding error checking
  # TODO: Use unicode to display black or white checkers
  def mark_board(row, col, player_num)
    checker = ''

    if player_num == 1
      checker = 'X'
    elsif player_num == 2
      checker = 'O'
    end
    
    @board[row][col] = checker
  end

  # Input checking method. Return col if col exists and has an empty space for a checker. If col does not exist or is full of checkers, return nil
  def verify_input(col)
    max_col_index = @board[0].length - 1
    col_array = get_col(col)

    # check if col exists on board
    return nil if col > max_col_index

    # check if col is full of checkers
    return nil if col_array.none? { |cell| cell.nil? }

    col
  end

  # return a string representation of the board
  # TODO: have column numbers at the bottom for aid in user input
  # TODO: cells with "nil" print with a blank space
  # TODO: try using Array#reduce here for practice
  def print_board
    output = ''
    @board.each { |row| output.concat("#{row.join(' | ')} \n") }
    output
  end

  # return an array of all rows in a column, from top to bottom
  def get_col(col_num)
    @board.map { |row| row[col_num] }
  end

end


# a_game = ConnectFourGame.new
# a_game.print_board
# a_game.player_move(0,0,1)
# puts a_game.print_board
# p a_game.get_col(0)