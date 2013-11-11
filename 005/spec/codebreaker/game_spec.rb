# rspec spec/codebreaker/game_spec.rb --color --format doc

require 'spec_helper'

module Codebreaker
  describe Game do
    # double() dynamically creates test double for real STDOUT
    # .as_null_object tells it to ignore other messages
    # let() assumes before(:each) wrapper and allows for no instance variables
    let(:output) { double('output').as_null_object }
    let(:game) { Game.new(output, 'simple_board.txt') }

    describe '#start' do

    end

    describe '#select chess piece' do
      context 'spot not found on board' do
        it 'should return blank' do
          game.select_chess_piece('z9').should == ''
        end
      end
      context 'spot found and piece selected' do
        it 'should return bP' do
          game.select_chess_piece('a2').should == 'bP'
        end
        it 'should return wP' do
          game.select_chess_piece('c7').should == 'wP'
        end
      end
    end

    describe '#pawn' do
      it 'has incorrect color = ILLEGAL' do
        output.should_receive(:puts).with('ILLEGAL')
        game.pawn('-','a2','a3','-')
      end
      it 'black moves forward 1 space = LEGAL' do
        output.should_receive(:puts).with('LEGAL')
        game.pawn('b','a2','a3','-')
      end
      it 'black moves forward 2 spaces = LEGAL' do
        output.should_receive(:puts).with('LEGAL')
        game.pawn('b','a2','a4','-')
      end
      it 'black moves forward 3 spaces = ILLEGAL' do
        output.should_receive(:puts).with('ILLEGAL')
        game.pawn('b','a2','a5','-')
      end
      it 'black moves diagonal right and takes out white = LEGAL' do
        output.should_receive(:puts).with('LEGAL')
        game.pawn('b','a2','b3','w')
      end
      it 'black moves diagonal left and takes out white = LEGAL' do
        output.should_receive(:puts).with('LEGAL')
        game.pawn('b','b2','a3','w')
      end
      it 'black moves diagonal but target not white = ILLEGAL' do
        output.should_receive(:puts).with('ILLEGAL')
        game.pawn('b','a2','b3','-')
      end
    end

    describe '#knight' do
      it 'moves 2 vertical and 2 horizontal = ILLEGAL' do
        output.should_receive(:puts).with('ILLEGAL')
        game.knight('b','a2','c4','-')
      end
      it 'move 1 horizontal and 2 vertical = LEGAL' do
        output.should_receive(:puts).with('LEGAL')
        game.knight('w','b8','c6','-')
      end
      it 'move 2 horizontal and 1 vertical = LEGAL' do
        output.should_receive(:puts).with('LEGAL')
        game.knight('w','b8','d7','-')
      end
    end
  end
end