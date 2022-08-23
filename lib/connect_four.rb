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

  



  private
  # return a string representation of the board
  # TODO: have column numbers at the bottom for aid in user input
  def print_board
    output = ''
    @board.each { |row| output.concat("#{row.join(' | ')} \n") }
    output
  end  

end


a_game = ConnectFourGame.new
a_game.print_board
