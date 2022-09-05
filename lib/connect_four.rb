# lib/connect_four.rb

require 'pry-byebug'

# Notes
# Connect Four board is 7 columns x 6 rows
# Use unicode to display black or white checkers
# use TDD-friendly game design from ruby_exercises 13-15
# user input is only a column number (1-7)

# Accomplishments
# First project where it was coded in small modular pieces for the purpose of developing tests
# Red-Green-Refactor practice for most methods
# Rspec tests helped a lot when I later had to introduce a default value in @board that wasn't nil. Helped me catch bugs across many methods without needing to find them via trial and error
# Wasn't able to google for a satisfactory algo to find the diagonals in a 2d array, so I developed my own. 

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

  # Play connect four
  def play_game
    print_game_instructions
    print_board
    # keep playing turns until the game is over
    turn_order until game_over?
    print_final_message
  end

  def print_game_instructions
    puts 'Game instructions'
  end

  # Print who won
  def print_final_message
    toggle_active_player # need to toggle the player back to the winning player, see #turn_order
    puts "Player #{@active_player} won!"
  end

  # Order of each player turn
  def turn_order
    player_turn(@active_player)
    print_board
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

  # Ask for valid player input, then commit the player move
  def player_turn(player_num)
    verified_col = ''
    loop do
      verified_col = verify_input(player_input(player_num))

      break if verified_col # break if not nil

      puts 'Input Error!'
    end

    # convert column number (1-7) to @board index (0-6)
    verified_col_index = verified_col - 1

    player_move(verified_col_index, player_num)
  end

  # Accept player input
  def player_input(player_num)
    puts "Player #{player_num} enter move: "
    gets.chomp
  end

  # Add a checker to the bottom of a valid column
  # Assume column has already been verified by #verify_input
  # Note: "top" row is @board[0]
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

  # Input checking method. Correct input is a column number between 1-7
  # Return col if col exists and has an empty space for a checker
  # Return nil if input is not an integer
  # Return nil if col does not exist (not 1-7)
  # Return nil if col is full of checkers
  def verify_input(col_num)
    # player input is converted into an integer. non_integers are converted to "0"
    col_num = col_num.to_i
    
    max_col_num = @board[0].length

    col_index = col_num - 1 # convert to array index
    chosen_col_values = get_col(col_index)

    # check if col_num exists on board
    # Assumption: #player_input converts input to integer. Non-integers are converted to "0" by to_i
    return nil if col_num > max_col_num || col_num < 1

    # check if col is full of checkers (does not contain the blank default value)
    return nil if chosen_col_values.none? { |cell| cell == ' ' }

    col_num
  end

  # Print a string representation of the board
  def print_board
    puts(@board.map { |row| row.join(' | ') })

    print_column_label
  end

  # Label each column of the board for user input
  # columns labeled 1 to 7 for easy input (no column 0)
  def print_column_label
    num_cols = @board[0].length
    column_numbers = (1..num_cols).to_a
    puts(column_numbers.join('   ')) # space needed to align numbers under each column
  end

  # Return an array of all rows in a column, from top to bottom
  def get_col(col_num)
    @board.map { |row| row[col_num] }
  end

  # Return true if a player has won (4 in a row, col or diagonal)
  # Give an array of each row, col, etc to four_equal? to determine if there are 4 player checkers in a row 
  # Note: 'return true' for each block may be redudant but here for clarity
  def game_over?
    # check horizontal (row) wins
    @board.each { |row| return true if four_equal?(row) }

    # check vertical (col) wins
    @board.transpose.each { |col| return true if four_equal?(col) }

    # check major diagonal wins
    major_diagonalize.each { |major_diagonal| return true if four_equal?(major_diagonal) }

    # check minor diagonal wins
    minor_diagonalize.each { |minor_diagonal| return true if four_equal?(minor_diagonal)}

    false
  end

  private
  
  # Iterate over all consecutive 4-tuple combinations in array. # Return true and break search if 4 consecutive values are equal
  def four_equal?(array)
    array.each_cons(4) do |a, b, c, d|
      # important to test that all values are not the default blank value
      return true if a == b && b == c && c == d && a != ' '
    end
  end

  # Return an array of all diagonals that start in the top left and go to the bottom right
  # only return diagonals that have 4 or more values
  def major_diagonalize(array = @board)
    # generate array of initial coordinates (row, col)
    # All coords of first col and first row
    # manually enter [0,0] and ignore this coord in loops below
    initial_coords = [[0, 0]]

    # first column coordinates, col = 0
    (1...array.length).each do |row|
      col = 0
      initial_coords << [row, col]
    end

    # first row coordinates (top row), row = 0
    (1...array[0].length).each do |col|
      row = 0
      initial_coords << [row, col]
    end

    # find the major diagonal starting from all initial coordinates
    major_diagonals = []
    initial_coords.each do |row, col|
      diagonal = []
      diagonal << array[row][col]

      # keep "descending" down the 2d array as long as there is a value
      until array[row + 1].nil? || array[row + 1][col + 1].nil?
        diagonal << array[row + 1][col + 1]
        row += 1
        col += 1
      end

      major_diagonals << diagonal
    end

    # only return major diagonals that have 4 or more values
    major_diagonals.select { |diagonal| diagonal.length >= 4 }
  end

  # Return an array of diagonals that start in the bottom left and go to the top right, "ascending"
  # only return diagonals that have 4 or more values
  def minor_diagonalize
    # reverse the rows only, keep the column order intact
    reversed_board = @board.map { |row| row.reverse } 
    major_diagonalize(reversed_board)
  end



end