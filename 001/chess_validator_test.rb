require_relative 'chess_validator'

describe Position do
	it "knows how to get zero based rows from a position string" do
		Position.new("a2").row.should == 1
		Position.new("c5").row.should == 4
	end

	it "knows how to get zero based columns from a position string" do
		Position.new("a2").column.should == 0 
		Position.new("c5").column.should == 2
	end
end

describe Pawn do

end

describe Board do

	let(:simple_board) {[	["bR", "bN", "bB", "bQ", "bK", "bB", "bN", "bR"], 
												["bP", "bP", "bP", "bP", "bP", "bP", "bP", "bP"], 
												["--", "--", "--", "--", "--", "--", "--", "--"], 
												["--", "--", "--", "--", "--", "--", "--", "--"], 
												["--", "--", "--", "--", "--", "--", "--", "--"], 
												["--", "--", "--", "--", "--", "--", "--", "--"], 
												["wP", "wP", "wP", "wP", "wP", "wP", "wP", "wP"], 
												["wR", "wN", "wB", "wQ", "wK", "wB", "wN", "wR"]]}
		
	it "knows where pieces are" do
		new_board = Board.new(simple_board)
	  new_board.piece_at("b1").should == "bN"
	  new_board.piece_at("f1").should == "bB"
	end

	it "knows that a pawn is a pawn" do
		new_board = Board.new(simple_board)
		new_board.is_pawn?("a2").should be_true
		new_board.is_pawn?("a3").should be_false
	end

	it "knows that a one space forward move is valid for black pawns" do
		new_board = Board.new(simple_board)
		new_board.valid_black_pawn_move("a2", "a3").should be_true
	end

	describe "valid_move" do
		
		it "isn't valid if there is no piece at the starting position" do
			new_board = Board.new(simple_board)
			new_board.valid_move("a3", "b3").should be_false
		end

		it "is valid for moving a pawn one space forward" do
			new_board = Board.new(simple_board)
			new_board.valid_move("a2", "a3").should be_true
		end

		it "is invalid for moving a pawn three spaces forward" do
			pending
			new_board = Board.new(simple_board)
			new_board.valid_move("a2", "a5").should be_false
		end

	end


end