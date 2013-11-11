class Coord
  attr_accessor :row, :col
  def initialize(*args)
    if (args.size == 1) then
      sq = args[0]
      @row = sq[1].ord - "1".ord
      @col = sq[0].ord - "a".ord
    else
      @row, @col = args
    end
  end
  def range(drow,dcol,n)
    (1..n).to_a.map { |i| [(i*drow)+row, (i*dcol)+col] }
  end
  def to_s
    "[#{row},#{col}]"
  end
  def inc(drow, dcol)
    Coord.new(row + drow, col + dcol)
  end
end

class Board
  def initialize
    @arr = []
  end
  def [](*args)
    if (args.size == 1)
      to = args[0]
      @arr[to.row][to.col]
    else
      row, col = args
      @arr[row][col]
    end
  end
  def <<(pieces)
    @arr.unshift pieces
  end
  def to_a
    @arr
  end
end

class Piece
  attr_accessor :color, :from
  def initialize(color,board,from)
    @color = color
    @board = board
    @from = from
  end
  def empty?(to)
    @board[to] == nil
  end
  def choose(white,black)
    color == :white ? white : black
  end
  def can_move(to)
    return false
  end
  def valid_move(to)
    piece = @board[to]
    return false if from == to
    return true if piece == nil || piece.color != color
    return false
  end
  def path_clear(to)
    range = from.range(to.row < from.row ? -1 : to.row == from.row ? 0 : 1,
                       to.col < from.col ? -1 : to.col == from.col ? 0 : 1,
                       [(to.row - from.row).abs,(to.col - from.col).abs].max - 1)
    range.all? {|row,col| @board[row,col] == nil }
  end
  def color_s
    color == :white ? "w" : "b"
  end
end

class Pawn < Piece
  def can_move(to)
    forward = choose(1,-1)
    return empty?(to) if from.col == to.col && from.row + forward == to.row
    if from.col == to.col && from.row + forward*2 == to.row && from.row == choose(1,6) then
      return empty?(to) && empty?(from.inc(forward, 0))
    end
    if (to.col - from.col).abs == 1 && from.row + forward == to.row then
      return valid_move(to) && !empty?(to)
    end
    super
  end
  def to_s
    color_s + "P"
  end
end

class Queen < Piece
  def can_move(to)
    return false if from.col != to.col && from.row != to.row &&
                    (from.col - to.col).abs != (from.row - to.row).abs
    return false if !path_clear(to)
    return valid_move(to)
  end
  def to_s
    color_s + "Q"
  end
end

class King < Piece
  def king_check?(to)
    @board.to_a.any? do |cols|
      cols.any? do |piece|
        if piece == nil
          false
        elsif piece.color == self.color
          false
        elsif piece.class != Pawn
          piece.can_move(to)
        else
          piece.from.row - to.row == choose(1, -1) && (piece.from.col - to.col).abs == 1
        end
      end
    end
  end
  def can_move(to)
    return false if 1 < (from.col - to.col).abs || 1 < (from.row - to.row).abs
    return false if king_check?(to)
    return valid_move(to)
  end
  def to_s
    color_s + "K"
  end
end

class Knight < Piece
  def can_move(to)
    return valid_move(to) if (from.col - to.col).abs == 1 && (from.row - to.row).abs == 2
    return valid_move(to) if (from.col - to.col).abs == 2 && (from.row - to.row).abs == 1
    super
  end
  def to_s
    color_s + "N"
  end
end

class Rook < Piece
  def can_move(to)
    return false if to.row != from.row && to.col != from.col
    return false if !path_clear(to)
    return valid_move(to)
  end
  def to_s
    color_s + "R"
  end
end

class Bishop < Piece
  def can_move(to)
    return false if (to.row - from.row).abs != (to.col - from.col).abs
    return false if !path_clear(to)
    return valid_move(to)
  end
  def to_s
    color_s + "B"
  end
end

class ChessValidator
  def initialize(filename)
    @board = Board.new
    row = 7
    File.open(filename, "r").each do |line|
      @board << line.scan(/\S+/).map.with_index { |str,col|
        color = str[0] == "w" ? :white : :black
        coord = Coord.new(row, col)
        case str[1]
        when "P"; Pawn.new(color,@board,coord)
        when "Q"; Queen.new(color,@board,coord)
        when "N"; Knight.new(color,@board,coord)
        when "R"; Rook.new(color,@board,coord)
        when "B"; Bishop.new(color,@board,coord)
        when "K"; King.new(color,@board,coord)
        end
      }
      row -= 1
    end
  end
  def render
    str = ""
    7.downto(0) do |row|
      8.times do |col|
        to = Coord.new(row,col)
        piece = @board[to]
        str << " " if col != 0
        str << (piece == nil ? "--" : piece.to_s)
      end
      str << "\n"
    end
    str
  end
  def [](sq)
    @board[Coord.new(sq)]
  end
  def check(from, to)
    piece = self[from]
    piece != nil && piece.can_move(Coord.new(to)) ? "LEGAL" : "ILLEGAL"
  end
end
