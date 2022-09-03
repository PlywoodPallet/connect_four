# lib/connect_four.rb

require 'pry-byebug'

# Notes
# Connect Four board is 7 columns x 6 rows
# Use unicode to display black or white checkers
# use TDD-friendly game design from ruby_exercises 13-15
# user input is only a column number (1-7)

class ConnectFourGame

  def initialize(row = 6, col = 7)
    # NOTE: row array goes from "top" to "bottom". Col array goes from "left" to "right"
    # Initialize default value as an empty space
    @board = Array.new(row) { Array.new(col, ' ') }

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
    puts print_board
    turn_order until game_over?
    puts 'Final message'
  end

  # Number of players (2) is hard coded
  def turn_order
    player_turn(@active_player)
    puts print_board
    toggle_active_player
  end

  # Switch the active player between 1 and 2
  def toggle_active_player
    if @active_player == 1
      @active_player = 2
    else
      @active_player = 1
    end
  end

  # Is it easy to read this method and understand what is happening?
  def player_turn(player_num)
    verified_col = ''
    loop do
      verified_col = verify_input(player_input(player_num))

      break if verified_col # break if not nil

      puts 'Input Error!'
    end

    player_move(verified_col, player_num)
  end

  # Accept player input
  def player_input(player_num)
    puts "Player #{player_num} enter move: "
    gets.chomp.to_i
  end

  # Add a checker to the bottom of a valid column
  # Assume column has already been verified by #verify_input to be within the game board and contain an empty space to add a checker
  # Note: "top" row is index 0
  def player_move(verified_col, player_num)
    col_array = get_col(verified_col)


    # start with the end of array, the "bottom" of the column  (the "last" row)
    row = col_array.length - 1 
    until row < 0 do
      if col_array[row] == ' '
        mark_board(row, verified_col, player_num)
        break
      end
      row -= 1
    end
  end

  # Directly mark the board with player checker, without error checking
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
  # TODO: return nil if input is not a number
  def verify_input(col)
    max_col_index = @board[0].length - 1
    col_array = get_col(col)

    # check if col exists on board
    return nil if col > max_col_index

    # check if col is full of checkers
    return nil if col_array.none? { |cell| cell == ' ' }

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

  # Return true if a player has won (4 in a row, col or diagonal)
  # 'return true' for each block may be redudant
  def game_over?
    # check horizontal (row) wins
    @board.each { |row| return true if all_equal?(row) }

    # check vertical (col) wins
    @board.transpose.each { |col| return true if all_equal?(col) }

    false
  end

  # Iterate over all consecutive 4-tuple combinations in array. # Return true and break search if 4 consecutive values are equal
  def all_equal?(array)
    array.each_cons(4) do |a, b, c, d|
      # important to test that all values are not the default blank value
      return true if a == b && b == c && c == d && a != ' '
    end
  end

  # return an array of all diagnonals that start in the top left and go to the bottom right
  # all diagonals that start when col = 0 or row = 0
  # working but needs a major refactor. Refactor into modular code that doesn't need to be repeated as much
  def major_diagonalize
    row_max = @board.length - 1
    col_max = @board[0].length - 1

    # find all major diagonals that start in the first (left-most) column, INCLUDING (0,0)
    row = row_max # start at the bottom row
    output = []
    while row >= 0
      diagonal = []
      diagonal << @board[row][0]

      i = row
      j = 0 # "col"

      # find all major diagonals starting at [row][col]
      until @board[i+1].nil? || @board[i+1][j+1].nil?
        diagonal << @board[i+1][j+1]
        i += 1
        j += 1
      end

      row -= 1
      # output << diagonal
    end

    # find all major diagonals that start in the first row EXCLUDING (0,0)
    col = 1
    while col <= col_max
      diagonal = []
      diagonal << @board[0][col]

      i = 0 # "row"
      j = col

      until @board[i+1].nil? || @board[i+1][j+1].nil?
        diagonal << @board[i+1][j+1]
        i += 1
        j += 1
      end

      col += 1
      output << diagonal
    end

    output
  end
end