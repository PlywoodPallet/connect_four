# lib/connect_four.rb

require_relative '../lib/connect_four.rb'

describe ConnectFourGame do

  # check if four checkers of one player is found
  # horizontal, vertical, diagonal (left and right)
  describe "#game_over?" do

    context 'when four checkers are horizontal' do
    subject(:game) { described_class.new }
      before do
        row = 0
        game.mark_board(row, 0, 1)
        game.mark_board(row, 1, 1)
        game.mark_board(row, 2, 1)
        game.mark_board(row, 3, 1)
      end
      it 'game_over? is true' do
        expect(game).to be_game_over
      end
    end

    context 'when four checkers are vertical' do
    subject(:game) { described_class.new }
      before do
        col = 0
        game.mark_board(5, col, 1)
        game.mark_board(4, col, 1)
        game.mark_board(3, col, 1)
        game.mark_board(2, col, 1)
      end
      it 'game_over? is true' do
        expect(game).to be_game_over
      end
    end

    context 'when four checkers are in major diagonal (descending)' do
      subject(:game) { described_class.new }
        before do
          game.mark_board(2, 0, 1)
          game.mark_board(3, 1, 1)
          game.mark_board(4, 2, 1)
          game.mark_board(5, 3, 1)
        end
        it 'game_over? is true' do
          expect(game).to be_game_over
        end
      end

    context 'when four checkers are in minor diagonal (ascending)' do
    subject(:game) { described_class.new }
      before do
        game.mark_board(5, 0, 1)
        game.mark_board(4, 1, 1)
        game.mark_board(3, 2, 1)
        game.mark_board(2, 3, 1)
      end
      it 'game_over? is true' do
        expect(game).to be_game_over
      end
    end


    # TODO: to test this correctly, I should fill the entire board
    # with a draw game
    context 'when there no four checkers in a row' do
    subject(:game) { described_class.new }
      before do
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
      end
      it 'game_over? is false' do
        expect(game).to_not be_game_over
      end
    end
  end


  describe "#player_move" do
    context 'When the column is empty' do
      subject(:game_move) { described_class.new }
      it 'Adds player 1 checker correctly' do
        col = 0
        player_num = 1
        
        game_move.player_move(col, player_num)

        first_column = game_move.get_col(col)
        expected_result = [' ', ' ', ' ', ' ', ' ', 'X']

        expect(first_column).to eq(expected_result)
      end
    end
    
    context 'When the column contains existing checkers and empty spaces' do 
      subject(:game_move) { described_class.new }
      col = 0
      player_num = 1

      before do
        game_move.player_move(col, player_num)
      end

      it 'Adds player 1 checker on the top of existing checkers' do
        game_move.player_move(col, player_num)

        first_column = game_move.get_col(col)
        expected_result = [' ', ' ', ' ', ' ', 'X', 'X']
      end
    end

    context 'When the column is full of checkers' do
      subject(:game_move) { described_class.new }

      col = 0
      player_num = 1

      before do 
        board = game_move.instance_variable_get(:@board)
        board_num_rows = board.length

        row = 0
        until row == board_num_rows do
          game_move.mark_board(row, col, player_num)
          row += 1
        end
      end
    
      # mostly already tested in #verify_input tests, but need to test that a message was printed stating that the move is invalid
      # it 'Returns error when adding player 1 checker into a full column' do

      #   game_move.player_move(col, player_num)

      #   error_message = 'ERROR'
      #   expect(game_move).to receive(:puts).with(error_message)
      # end
    end
  end


  # Test a basic version of this method without error checking
  describe '#mark_board' do
    subject(:game_mark) { described_class.new }

    it 'Adds player 1 checker in specific cell' do 
      row = 0
      col = 0
      player_num = 1
      
      game_mark.mark_board(row, col, player_num)
      board = game_mark.instance_variable_get(:@board)
      cell = board[row][col]

      expect(cell).to eq('X')
    end

    it 'Adds player 2 checker in specific cell' do 
      row = 0
      col = 0
      player_num = 2
      
      game_mark.mark_board(row, col, player_num)
      board = game_mark.instance_variable_get(:@board)
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
      expected_result = ['X', ' ', ' ', ' ', ' ', ' ']

      expect(first_column).to eq(expected_result)
    end
  end
  
  # Purpose of this method
  # Determine if the input column number is a valid number on the board
  # Determine if the input column number has a free row to add a checker
  describe '#verify_input' do 
    context 'when the board is empty, returns valid input when given empty column' do
      subject(:game_verify) { described_class.new }

      it 'when input is the first column (default = 1)' do
        min_col = 1

        verified_input = game_verify.verify_input(min_col)
        expect(verified_input).to eq(min_col)
      end

      it 'when input is the last column (default = 7)' do
        board = game_verify.instance_variable_get(:@board)
        max_col = board[0].length - 1

        verified_input = game_verify.verify_input(max_col)
        expect(verified_input).to eq(max_col)
      end
    end

    context 'when a particular column is full' do
      subject(:game_verify) { described_class.new }

      it 'returns nil when input 1 and column 1 is full' do
        col_num = 1
        col_index = 0

        player_num = 1
        board = game_verify.instance_variable_get(:@board)
        board_num_rows = board.length

        row = 0
        until row == board_num_rows do
          game_verify.mark_board(row, col_index, player_num)
          row += 1
        end

        verified_input = game_verify.verify_input(col_num)
        expect(verified_input).to eq(nil)
      end
    end

    context 'when given an invalid column that is off the board' do
      subject(:game_verify) { described_class.new }

      it 'user inputs 100, returns nil' do 
        invalid_col = 100

        verified_input = game_verify.verify_input(invalid_col)
        expect(verified_input).to eq(nil)
      end

      it 'user inputs -100, returns nil' do 
        invalid_col = -100

        verified_input = game_verify.verify_input(invalid_col)
        expect(verified_input).to eq(nil)
      end

      it 'user inputs a character, returns nil' do 
        invalid_input = 'd'

        verified_input = game_verify.verify_input(invalid_input)
        expect(verified_input).to eq(nil)
      end

      it 'user inputs a symbol, returns nil' do 
        invalid_input = '$'

        verified_input = game_verify.verify_input(invalid_input)
        expect(verified_input).to eq(nil)
      end
    end
  end



end