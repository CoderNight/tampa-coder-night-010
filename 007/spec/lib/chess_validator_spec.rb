require "chess_validator"
require "debugger"

describe Coord do
  context "#range" do
    it "ranges on origin with 1 major diagonal backward" do
      Coord.new(0,0).range(1,-1, 1).should == [[1,-1]]
    end
    it "ranges on center with 1 major diagonal backward" do
      Coord.new(4,4).range(1,-1, 1).should == [[5,3]]
    end
    it "ranges on center with 1 major diagonal " do
      Coord.new(4,4).range(-1,1, 1).should == [[3,5]]
    end
    it "ranges on center with 2 minor diagonal " do
      Coord.new(4,4).range(-1,-1, 2).should == [[3,3],[2,2]]
    end
  end
end

describe ChessValidator do
  context "simple" do
    let (:validator) { ChessValidator.new("simple_board.txt") }
    context "#initialize" do
      it "has a white pawn on a2" do
        validator["a2"].class.should == Pawn
        validator["a2"].color.should == :white
      end
      it "has a white queen on d8" do
        validator["d8"].class.should == Queen
        validator["d8"].color.should == :black
      end
    end
    context "#render" do
      it "renders the simple board" do
        validator.render.should == <<-EOS
bR bN bB bQ bK bB bN bR
bP bP bP bP bP bP bP bP
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
wP wP wP wP wP wP wP wP
wR wN wB wQ wK wB wN wR
        EOS
      end
    end
    context "#check" do
      it "moves a3" do
        validator.check("a2", "a3").should == "LEGAL"
      end
      it "moves a4" do
        validator.check("a2", "a4").should == "LEGAL"
      end
      it "moves a5" do
        validator.check("a2", "a5").should == "ILLEGAL"
      end
      it "moves ..a6" do
        validator.check("a7", "a6").should == "LEGAL"
      end
      it "moves ..a5" do
        validator.check("a7", "a5").should == "LEGAL"
      end
      it "moves ..a4" do
        validator.check("a7", "a4").should == "ILLEGAL"
      end
      it "moves ..ab6" do
        validator.check("a7", "b6").should == "ILLEGAL"
      end
      it "moves ..Na6" do
        validator.check("b8", "a6").should == "LEGAL"
      end
      it "moves ..Nc6" do
        validator.check("b8", "c6").should == "LEGAL"
      end
      it "moves ..Nd7" do
        validator.check("b8", "d7").should == "ILLEGAL"
      end
      it "moves e3" do
        validator.check("e2", "e3").should == "LEGAL"
      end
      it "moves e3e2" do
        validator.check("e3", "e2").should == "ILLEGAL"
      end
    end
  end
  context "complex" do
    let (:validator) { ChessValidator.new("complex_board.txt") }

    # 8 bK -- -- -- -- bB -- --
    # 7 -- -- -- -- -- bP -- --
    # 6 -- bP wR -- wB -- bN --
    # 5 wN -- bP bR -- -- -- wP
    # 4 -- -- -- -- wK wQ -- wP
    # 3 wR -- bB wN wP -- -- --
    # 2 -- wP bQ -- -- wP -- --
    # 1 -- -- -- -- -- wB -- --
    #    a  b  c  d  e  f  g  h

    context "#render" do
      it "renders the complex board" do
        validator.render.should == <<-EOS
bK -- -- -- -- bB -- --
-- -- -- -- -- bP -- --
-- bP wR -- wB -- bN --
wN -- bP bR -- -- -- wP
-- -- -- -- wK wQ -- wP
wR -- bB wN wP -- -- --
-- wP bQ -- -- wP -- --
-- -- -- -- -- wB -- --
        EOS
      end
    end
    context "check" do
      it "moves b3" do
        validator.check("b2", "b3").should == "LEGAL"
      end
      it "moves b7f2" do
        validator.check("f2", "b7").should == "ILLEGAL"
      end
      it "moves b4a8" do
        validator.check("b4", "a8").should == "ILLEGAL"
      end
      it "moves ..Kg5" do
        validator.check("a8", "g5").should == "ILLEGAL"
      end
      it "moves b4" do
        validator.check("b2", "b4").should == "LEGAL"
      end
      it "moves h7f6" do
        validator.check("h7", "f6").should == "ILLEGAL"
      end
      it "moves e3b1" do
        validator.check("e3", "b1").should == "ILLEGAL"
      end
      it "moves b7e4" do
        validator.check("b7", "e4").should == "ILLEGAL"
      end
      it "moves b5" do
        validator.check("b2", "b5").should == "ILLEGAL"
      end
      it "moves g7g2" do
        validator.check("g7", "g2").should == "ILLEGAL"
      end
      it "moves ..f7f8" do
        validator.check("f7", "f8").should == "ILLEGAL"
      end
      it "moves g7e8" do
        validator.check("g7", "e8").should == "ILLEGAL"
      end
      it "moves f5g5" do
        validator.check("f5", "g5").should == "ILLEGAL"
      end
      it "moves ..f6" do
        validator.check("f7", "f6").should == "LEGAL"
      end
      it "moves ..Bxa2" do
        validator.check("c3", "a2").should == "ILLEGAL"
      end
      it "moves e1c1" do
        validator.check("e1", "c1").should == "ILLEGAL"
      end
      it "moves ..f5" do
        validator.check("f7", "f5").should == "LEGAL"
      end
      it "moves g8c6" do
        validator.check("g8", "c6").should == "ILLEGAL"
      end
      it "moves b2d5" do
        validator.check("b2", "d5").should == "ILLEGAL"
      end
      it "moves f7f4" do
        validator.check("f7", "f4").should == "ILLEGAL"
      end
      it "moves f6f3" do
        validator.check("f6", "f3").should == "ILLEGAL"
      end
      it "moves c5f4" do
        validator.check("c5", "f4").should == "ILLEGAL"
      end
      it "moves b6a5" do
        validator.check("b6", "a5").should == "LEGAL"
      end
      it "moves Bc3d7" do
        validator.check("c3", "d7").should == "ILLEGAL"
      end
      it "moves f6" do
        validator.check("b2", "f6").should == "ILLEGAL"
      end
      it "moves Kd8" do
        validator.check("e4", "d8").should == "ILLEGAL"
      end
      it "moves d2g6" do
        validator.check("d2", "g6").should == "ILLEGAL"
      end
      it "moves bxc3" do
        validator.check("b2", "c3").should == "LEGAL"
      end
      it "moves Rg5" do
        validator.check("a3", "g5").should == "ILLEGAL"
      end
      it "moves h6e8" do
        validator.check("h6", "e8").should == "ILLEGAL"
      end
      it "moves Nb5" do
        validator.check("d3", "b5").should == "ILLEGAL"
      end
      it "moves d6f3" do
        validator.check("d6", "f3").should == "ILLEGAL"
      end
      it "moves ..c4" do
        validator.check("c5", "c4").should == "LEGAL"
      end
      it "moves f6a3" do
        validator.check("f6", "a3").should == "ILLEGAL"
      end
      it "moves b7c1" do
        validator.check("b7", "c1").should == "ILLEGAL"
      end
      it "moves Bf1" do
        validator.check("f1", "f1").should == "ILLEGAL"
      end
      it "moves ..b4" do
        validator.check("b6", "b4").should == "ILLEGAL"
      end
      it "moves a7e5" do
        validator.check("a7", "e5").should == "ILLEGAL"
      end
      it "moves ..bxc5" do
        validator.check("b6", "c5").should == "ILLEGAL"
      end
      it "moves ..Qe7" do
        validator.check("c2", "e7").should == "ILLEGAL"
      end
      it "moves d4f5" do
        validator.check("d4", "f5").should == "ILLEGAL"
      end
      it "moves a7g8" do
        validator.check("a7", "g8").should == "ILLEGAL"
      end
      it "moves a7d1" do
        validator.check("a7", "d1").should == "ILLEGAL"
      end
      it "moves ..c5b4" do
        validator.check("c5", "b4").should == "ILLEGAL"
      end
      it "moves c4e3" do
        validator.check("c4", "e3").should == "ILLEGAL"
      end
      it "moves h4h3" do
        validator.check("h4", "h3").should == "ILLEGAL"
      end
      it "moves b5b2" do
        validator.check("b5", "b2").should == "ILLEGAL"
      end
      it "moves b2g4" do
        validator.check("b2", "g4").should == "ILLEGAL"
      end
      it "moves h3h4" do
        validator.check("h3", "h4").should == "ILLEGAL"
      end
      it "moves h8d3" do
        validator.check("h8", "d3").should == "ILLEGAL"
      end
      it "moves h8h7" do
        validator.check("h8", "h7").should == "ILLEGAL"
      end
      it "moves h2h3" do
        validator.check("h2", "h3").should == "ILLEGAL"
      end
      it "moves e8c4" do
        validator.check("e8", "c4").should == "ILLEGAL"
      end
      it "moves Ra1" do
        validator.check("a3", "a1").should == "LEGAL"
      end
      it "moves Nb5" do
        validator.check("d3", "b5").should == "ILLEGAL"
      end
      it "moves Ra1" do
        validator.check("a3", "a1").should == "LEGAL"
      end
      it "moves ..Rd3" do
        validator.check("d5", "d3").should == "LEGAL"
      end
      it "moves ..Rf5" do
        validator.check("d5", "f5").should == "LEGAL"
      end
      it "moves b4f6" do
        validator.check("b4", "f6").should == "ILLEGAL"
      end
      it "moves ..Rg2" do
        validator.check("d5", "g2").should == "ILLEGAL"
      end
      it "moves c8d4" do
        validator.check("c8", "d4").should == "ILLEGAL"
      end
      it "moves ..Rb5" do
        validator.check("d5", "b5").should == "ILLEGAL"
      end
      it "moves Rd5" do
        validator.check("c6", "d5").should == "ILLEGAL"
      end
      it "moves f3b5" do
        validator.check("f3", "b5").should == "ILLEGAL"
      end
      it "moves a1g6" do
        validator.check("a1", "g6").should == "ILLEGAL"
      end
      it "moves ..Ne5" do
        validator.check("g6", "e5").should == "LEGAL"
      end
      it "moves Nde6" do
        validator.check("d3", "e6").should == "ILLEGAL"
      end
      it "moves ..Nga7" do
        validator.check("g6", "a7").should == "ILLEGAL"
      end
      it "moves ..Nh4" do
        validator.check("g6", "h4").should == "LEGAL"
      end
      it "moves Rd8" do
        validator.check("c6", "d8").should == "ILLEGAL"
      end
      it "moves Rh8" do
        validator.check("a3", "h8").should == "ILLEGAL"
      end
      it "moves g8f8" do
        validator.check("g8", "f8").should == "ILLEGAL"
      end
      it "moves c7f2" do
        validator.check("c7", "f2").should == "ILLEGAL"
      end
      it "moves Ndc4" do
        validator.check("d3", "c4").should == "ILLEGAL"
      end
      it "moves Na4" do
        validator.check("a5", "a4").should == "ILLEGAL"
      end
      it "moves Nab5" do
        validator.check("a5", "b5").should == "ILLEGAL"
      end
      it "moves Ba8" do
        validator.check("f1", "a8").should == "ILLEGAL"
      end
      it "moves Qg1" do
        validator.check("c2", "g1").should == "ILLEGAL"
      end
      it "moves e5a4" do
        validator.check("e5", "a4").should == "ILLEGAL"
      end
      it "moves h5f1" do
        validator.check("h5", "f1").should == "ILLEGAL"
      end
      it "moves B4" do
        validator.check("e6", "g4").should == "LEGAL"
      end
      it "moves g5h2" do
        validator.check("g5", "h2").should == "ILLEGAL"
      end
      it "moves ..Bb2" do
        validator.check("c3", "b2").should == "LEGAL"
      end
      it "moves h2c7" do
        validator.check("h2", "c7").should == "ILLEGAL"
      end
      it "moves Bef3" do
        validator.check("e6", "f3").should == "ILLEGAL"
      end
      it "moves ..Bbc4" do
        validator.check("c3", "c4").should == "ILLEGAL"
      end
      it "moves Bc4" do
        validator.check("f1", "c4").should == "ILLEGAL"
      end
      it "moves b3a6" do
        validator.check("b3", "a6").should == "ILLEGAL"
      end
      it "moves c4b3" do
        validator.check("c4", "b3").should == "ILLEGAL"
      end
      it "moves c1h6" do
        validator.check("c1", "h6").should == "ILLEGAL"
      end
      it "moves Nac5" do
        validator.check("a5", "c5").should == "ILLEGAL"
      end
      it "moves Qf7" do
        validator.check("f4", "f7").should == "LEGAL"
      end
      it "moves ..Qc6" do
        validator.check("c2", "c6").should == "ILLEGAL"
      end
      it "moves f6g2" do
        validator.check("f6", "g2").should == "ILLEGAL"
      end
      it "moves d2a1" do
        validator.check("d2", "a1").should == "ILLEGAL"
      end
      it "moves Ka3" do
        validator.check("e4", "a3").should == "ILLEGAL"
      end
      it "moves ..Qd3" do
        validator.check("c2", "d3").should == "LEGAL"
      end
      it "moves ..Kc6" do
        validator.check("a8", "c6").should == "ILLEGAL"
      end
      it "moves d6d1" do
        validator.check("d6", "d1").should == "ILLEGAL"
      end
      it "moves ..Qe4" do
        validator.check("c2", "e4").should == "ILLEGAL"
      end
      it "moves d6g2" do
        validator.check("d6", "g2").should == "ILLEGAL"
      end
      it "moves a6a7" do
        validator.check("a6", "a7").should == "ILLEGAL"
      end
      it "moves ..Qc4" do
        validator.check("c2", "c4").should == "ILLEGAL"
      end
      it "moves ..Ka7" do
        validator.check("a8", "a7").should == "LEGAL"
      end
      it "moves c4d3" do
        validator.check("c4", "d3").should == "ILLEGAL"
      end
      it "moves ..Bch5" do
        validator.check("c3", "h5").should == "ILLEGAL"
      end
      it "moves b4c7" do
        validator.check("b4", "c7").should == "ILLEGAL"
      end
      it "moves Bd5" do
        validator.check("e6", "d5").should == "LEGAL"
      end
      it "moves bxd6" do
        validator.check("b6", "d6").should == "ILLEGAL"
      end
      it "moves e5f8" do
        validator.check("e5", "f8").should == "ILLEGAL"
      end
      it "moves Bff6" do
        validator.check("f1", "f6").should == "ILLEGAL"
      end
      it "moves ..Ka6" do
        validator.check("a8", "a6").should == "ILLEGAL"
      end
      it "moves ..Kc6" do
        validator.check("a8", "c6").should == "ILLEGAL"
      end
      it "moves Ke5" do
        validator.check("e4", "e5").should == "ILLEGAL"
      end
      it "moves h2a5" do
        validator.check("h2", "a5").should == "ILLEGAL"
      end
      it "moves c8e1" do
        validator.check("c8", "e1").should == "ILLEGAL"
      end
      it "moves eh2" do
        validator.check("e3", "h2").should == "ILLEGAL"
      end
      it "moves f2h3" do
        validator.check("f3", "h3").should == "ILLEGAL"
      end
    end
  end
end
