# lib/connect_four.rb

# Notes
# Connect Four board is 7 columns x 6 rows
# Use unicode to display black or white checkers
# use TDD-friendly game design from ruby_exercises 14-15
# user input is only a column number (1-7)

class ConnectFourGame

  def initialize(row = 6, col = 7)
    @board = Array.new(row) { Array.new(col) }

    # for IRB @board = Array.new(6) { Array.new(7) }
  end


  # Basic player move method. Need a basic method in place before adding error checking
  # TODO: Use unicode to display black or white checkers
  def player_move(row, col, player_num)
    checker = ''

    if player_num == 1
      checker = 'X'
    elsif player_num == 2
      checker = 'O'
    end
    
    @board[row][col] = checker
  end

  # return a string representation of the board
  # TODO: have column numbers at the bottom for aid in user input
  # TODO: cells with "nil" print with a blank space
  def print_board
    output = ''
    @board.each { |row| output.concat("#{row.join(' | ')} \n") }
    output
  end  

end


# a_game = ConnectFourGame.new
# a_game.print_board
# a_game.player_move(0,0,1)
# puts a_game.print_board