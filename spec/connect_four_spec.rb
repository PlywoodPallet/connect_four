# lib/connect_four.rb

require_relative '../lib/connect_four.rb'

describe ConnectFourGame do

  # Test a basic version of this method without error checking
  describe '#player_move' do
    subject(:game_move) { described_class.new }

    it 'Adds player 1 checker in specific cell' do 
      row = 0
      col = 0
      player_num = 1
      
      game_move.player_move(row, col, player_num)
      board = game_move.instance_variable_get(:@board)
      cell = board[row][col]

      expect(cell).to eq('X')
    end

    it 'Adds player 2 checker in specific cell' do 
      row = 0
      col = 0
      player_num = 2
      
      game_move.player_move(row, col, player_num)
      board = game_move.instance_variable_get(:@board)
      cell = board[row][col]

      expect(cell).to eq('O')
    end
  end
  
  
  # Purpose of this method
  # Determine if the input column number is a valid number on the board
  # Determine if the input column number has a free row to add a checker
  describe '#verify_input' do 
    

    context 'when the board is empty' do
      subject(:game_verify) { described_class.new }

      xit 'returns valid input when given valid column' do

      end

    end

    context 'when a particular column is full' do
      xit 'returns nil when column is full' do

      end
    end

    context 'when given an invalid column that is off the board' do
      xit 'returns nil' do 

      end
    end
  end



end