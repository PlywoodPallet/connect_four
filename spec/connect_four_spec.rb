# lib/connect_four.rb

require_relative '../lib/connect_four.rb'

describe ConnectFourGame do

  # Test a basic version of this method without error checking
  describe '#mark_board' do
    subject(:game_move) { described_class.new }

    it 'Adds player 1 checker in specific cell' do 
      row = 0
      col = 0
      player_num = 1
      
      game_move.mark_board(row, col, player_num)
      board = game_move.instance_variable_get(:@board)
      cell = board[row][col]

      expect(cell).to eq('X')
    end

    it 'Adds player 2 checker in specific cell' do 
      row = 0
      col = 0
      player_num = 2
      
      game_move.mark_board(row, col, player_num)
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
      
      game_column.mark_board(row, col, player_num)

      first_column = game_column.get_col(col)
      expected_result = ['X', nil, nil, nil, nil, nil]

      expect(first_column).to eq(expected_result)
    end
  end
  
  # Purpose of this method
  # Determine if the input column number is a valid number on the board
  # Determine if the input column number has a free row to add a checker
  describe '#verify_input' do 
    

    context 'when the board is empty, returns valid input when given empty column' do
      subject(:game_verify) { described_class.new }

      it 'when input is the first column (default = 0)' do
        min_col = 0

        verified_input = game_verify.verify_input(min_col)
        expect(verified_input).to eq(min_col)
      end

      it 'when input is the last column (default = 6)' do
        board = game_verify.instance_variable_get(:@board)
        max_col = board[0].length - 1

        verified_input = game_verify.verify_input(max_col)
        expect(verified_input).to eq(max_col)
      end


    end

    context 'when a particular column is full' do
      subject(:game_verify) { described_class.new }

      it 'returns nil when column is full' do
        col = 0
        player_num = 1
        board = game_verify.instance_variable_get(:@board)
        board_num_rows = board.length

        row = 0
        until row == board_num_rows do
          game_verify.mark_board(row, col, player_num)
          row += 1
        end

        verified_input = game_verify.verify_input(col)
        expect(verified_input).to eq(nil)
      end
    end

    context 'when given an invalid column that is off the board' do
      subject(:game_verify) { described_class.new }

      it 'returns nil' do 
        board = game_verify.instance_variable_get(:@board)
        invalid_col = board[0].length

        verified_input = game_verify.verify_input(invalid_col)
        expect(verified_input).to eq(nil)
      end
    end
  end



end