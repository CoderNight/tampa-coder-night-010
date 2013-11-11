require_relative 'chess_validator2'

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



describe Board do

	before do
		@new_board = Board.new(simple_board)
	end

	let(:simple_board) {[	["bR", "bN", "bB", "bQ", "bK", "bB", "bN", "bR"], 
												["bP", "bP", "bP", "bP", "bP", "bP", "bP", "bP"], 
												["--", "--", "--", "--", "--", "--", "--", "--"], 
												["--", "--", "--", "--", "--", "--", "--", "--"], 
												["--", "--", "--", "--", "--", "--", "--", "--"], 
												["--", "--", "--", "--", "--", "--", "--", "--"], 
												["wP", "wP", "wP", "wP", "wP", "wP", "wP", "wP"], 
												["wR", "wN", "wB", "wQ", "wK", "wB", "wN", "wR"]]}
		
	it "knows where pieces are" do
	  @new_board.piece_at("b1").should == "bN"
	  @new_board.piece_at("f1").should == "bB"
	end

	it "knows that a pawn is a pawn" do
		@new_board.is_pawn?("b2").should be_true
		@new_board.is_pawn?("a3").should be_false
	end

	it "knows that a bishop is a bishop" do
		@new_board.is_bishop?("f1").should be_true
		@new_board.is_bishop?("a3").should be_false
	end	

	it "knows that a queen is a queen" do
		@new_board.is_queen?("d1").should be_true
		@new_board.is_queen?("a3").should be_false
	end	

	it "knows that a rook is a rook" do
		@new_board.is_rook?("a1").should be_true
		@new_board.is_rook?("a3").should be_false
	end	

	it "knows that a king is a king" do
		@new_board.is_king?("e1").should be_true
		@new_board.is_king?("a3").should be_false
	end	

	it "knows that a knight is a knight" do
		@new_board.is_knight?("b1").should be_true
		@new_board.is_knight?("a3").should be_false
	end	

	describe "valid_move" do
			
		describe Pawn do
			before do
				@new_board = Board.new(simple_board)
			end
				
			it "knows that a one space forward move is valid for black pawns" do
				@new_board.valid_black_pawn_move("a2", "a3").should be_true
			end				

			it "knows that a one space forward move is valid for white pawns" do
				@new_board.valid_white_pawn_move("a6", "a5").should be_true
			end				

			it "is valid for moving a pawn one space forward" do
				pending				
				@new_board.valid_move("a2", "a3").should be_true
			end

			it "is invalid for moving a pawn three spaces forward" do
				pending
				@new_board.valid_move("a2", "a5").should be_false
			end
		end
	
		
		it "isn't valid if there is no piece at the starting position" do
			pending
			new_board.valid_move("a3", "b3").should be_false
		end
	end

		




end