# main.rb

require './lib/connect_four.rb'

game = ConnectFourGame.new

game.mark_board(3, 0, 1)
game.mark_board(4, 0, 1)
game.mark_board(5, 0, 1)
game.mark_board(2, 1, 1)
game.mark_board(3, 2, 1)
game.mark_board(4, 2, 1)
game.mark_board(5, 2, 1)

game.mark_board(2, 0, 2)
game.mark_board(3, 1, 2)
game.mark_board(4, 1, 2)
game.mark_board(5, 1, 2)
game.mark_board(2, 2, 2)
game.mark_board(5, 3, 2)

game.player_move(4,1)
game.player_move(5,2)
game.player_move(5,1)
game.player_move(5,2)
game.player_move(4,2)
game.player_move(6,2)

puts game.print_board

p game.major_diagonalize