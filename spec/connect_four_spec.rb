# lib/connect_four.rb

require_relative './lib/connect_four.rb'

describe ConnectFourGame do

  describe '#player_input' do


  end


  # Purpose of this method
  # Determine if the input column number is a valid number on the board
  # Determine if the input column number has a free row to add a checker
  describe '#verify_input' do 
    

    context 'when the board is empty' do
      subject(:game_verify) { described_class.new }

      it 'returns valid input when given valid column' do

      end

    end

    context 'when a particular column is full' do
      it 'returns nil when column is full' do

      end
    end

    context 'when given an invalid column that is off the board' do
      it 'returns nil' do 

      end
    end
  end



end