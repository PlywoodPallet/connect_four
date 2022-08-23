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
  
  # assume default game board, 6 row x 7 col 
  describe "#get_col" do
    subject(:game_column) { described_class.new }

    it 'returns all rows in a column, from top to bottom' do
      row = 0
      col = 0
      player_num = 1
      
      game_column.player_move(row, col, player_num)

      first_column = game_column.get_col(col)
      expected_result = ['X', nil, nil, nil, nil, nil]

      expect(first_column).to eq(expected_result)
    end
  end
  
  # Purpose of this method
  # Determine if the input column number is a valid number on the board
  # Determine if the input column number has a free row to add a checker
  describe '#verify_input' do 
    

    context 'when the board is empty' do
      subject(:game_verify) { described_class.new }

      xit 'returns valid input when given empty column' do
        col = 0
        verified_input = game_verify.verify_input(col)
        expect(verified_input).to eq(0)
      end

    end

    context 'when a particular column is full' do
      subject(:game_verify) { described_class.new }

      xit 'returns nil when column is full' do
        col = 0
        board = instance_variable_get(:@board)



      end
    end

    context 'when given an invalid column that is off the board' do
      subject(:game_verify) { described_class.new }

      xit 'returns nil' do 

      end
    end
  end



end