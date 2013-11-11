
class Pawn
	def intialize(position)
		@position = position
	end

	def valid_pawn_move?(ending_position)
		# two space moves
		# one space moves

		# eventualy direction based on player
	end
end

class Board
  BLANK = "--"

	def initialize(pieces)
		@pieces = pieces
	end

	def piece_at(position_string)
		board_position = Position.new(position_string)

		@pieces[board_position.row][board_position.column]
	end

	def is_pawn?(position)
		piece_at(position).include?("P")			
	end

	def valid_move(starting_position, ending_position)
		piece_at(starting_position) != BLANK

		if is_pawn?(position)
			pawn = Pawn.new(position)
			pawn.valid_pawn_move?(ending_position)
		else
			# ...
		end
	end

	def valid_black_pawn_move(starting_position, ending_position)
		#true if row at ending position is 1 more than starting position
		starting_position_row = starting_position[1].to_i 
		ending_position_row 	= ending_position[1].to_i

		ending_position_row == starting_position_row + 1
	end
end

class Position
	def initialize(position_string)
		@position_string = position_string		
	end

	def row
		@position_string[1].to_i - 1
	end

	def column
		column = @position_string[0]
		columns = %w{a b c d e f g h}
		columns.index(column)
	end
end

# rows = File.read("simple_moves.txt").split("\n")
# moves = rows.map do |row|
# 	row.split(" ")
# end

# rows = File.read("simple_board.txt").split("\n")
# 		pieces = rows.map do |row|
# 	 				row.split(" ")
# 				end

# new_board = Board.new(pieces)

# moves.each do |move|
# 	starting_position = move[0]
# 	ending_position   = move[1]
	
# 	valid_move = new_board.valid_move(starting_position, ending_position)
# 	if valid_move
# 		puts "LEGAL"
# 	else
# 		puts "ILLEGAL"
# 	end
# end
	

