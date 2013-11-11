require 'rspec'
require 'chess_validator/chess_validator'

# puts $:
module ChessValidator
  describe Validate do
    let(:output) { double('output').as_null_object }
    let(:v) { Validate.new(1,1) }

    describe '#start' do
      it 'sends a welcome message' do
       output.should_receive(:puts).with('Welcome to Chess Validator!')
       v.start
      end
    end



    it 'should return illegal' do
      v = Validate.new('a2','a3')
      v.pawn.should_receive(:puts).with('ILLEGAL')
    end

  end

end

