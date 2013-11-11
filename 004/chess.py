'''
I wanted to work on a heavy OOP style. It went quite poorly -- The DRY priciple 
shall be found no where below! Duplicated code everywhere. 

Additionally, I tried to work a little on generators and lazy execution
in general rather than computing everything upfront (mainly when computing the moves). 

If I were to refactor, I'd dump all the individual classes and swap them out for lookups 
in a dictionary. I'd then probably wrap all that up in a thin `GameLogic` class so that things like 
`compute()` and is_valid_move() could be logically grouped together. 

'''

import sys
import math
import itertools
from itertools import * 


class Vector(object): 
	def __init__(self, p1, p2):
		self.x = p1.x - p2.x 
		self.y = p1.y - p2.y 

	def magnitude(self):
		return math.sqrt(self.x*self.x + self.y*self.y)

	def normalize(self): 
		magnitude = self.magnitude()
		return Position((self.x/magnitude, self.y/magnitude))

	def angle(self):
		n = self.normalize() 
		return math.atan2(n.x, n.y)*180/math.pi

	def discrete_normalize(self): 
		nv = self.normalize()
		return Position((
			int(round(nv.x)),
			int(round(nv.y))
			))


	def __str__(self): 
		return str((self.x, self.y))


class Tile(object): 
	def __init__(self, x, y, chess_piece): 
		self.position = Position((x,y))
		self.piece = chess_piece
		self.is_occupied = True if chess_piece is not None else False 

	def __str__(self): 
		return 'Board tile @ {}, with piece: {}'.format(self.position, self.piece)



class ChessBoard(object): 

	def __init__(self): 
		self.pieces = {
			'R' : Rook,
			'N' : Knight,
			'B' : Bishop,
			'Q' : Queen, 
			'K' : King,
			'P' : Pawn
		}

		board_data = self.load('simple_board.txt') 
		self.board = self.build_matrix(board_data)

	def load(self, filename):
		with open(filename, 'rb') as f: 
			return f.read()

	def contruct_tile(self, this_square, row_index):
		contents, column = this_square
		if contents == '--':
			return Tile(row_index, column, None)

		color, piece_code = contents

		piece_type = self.lookup_piece(piece_code)
		chess_piece = piece_type(color, row_index, column)
		return Tile(row_index, column, chess_piece)

	def build_matrix(self, data): 
		result = map(lambda x: x.split(' '), data.split('\n'))

		board = []
		for index, row in enumerate(result): 
			board.append(map(lambda x: self.contruct_tile(x, index), 
						izip(row, itertools.count())))
		return board
	
	def init_board(self, data): 
		pass

	def lookup_piece(self, piece):
		return self.pieces.get(piece)

	def get_tile_at(self, position): 
		row, col = position
		return self.board[row][col]


class ChessPiece(object): 
	def __init__(self, color, x, y): 
		self.color = color
		self.position = Position((x,y))
		self.directions = {
			'UP' : -1, 
			'DOWN' : 1
		}

	def calulate_moves(self, valid_moves):
		calulated_moves = imap(lambda x: self.position + x, valid_moves)
		# Make sure none if the moves are off the board. 
		return filter(lambda x: x[0]>=0 and x[1]>=0 
						and x[0] < 8 and x[1] < 8, calulated_moves)

	def base_conditions_met(self, tile, calulated_moves): 
		''' 
		Sanity check for the move. Make sure that
			(a) It's a valid piece movement pattern
			(b) Colors are different 
		'''		
		if tile.position not in calulated_moves: 
			print 'not in calc moves'
			return False

		if tile.is_occupied and tile.piece.color == self.color: 
			print 'Same color. Cannot move'
			return False 
		return True 

class Position(object): 
	def __init__(self, position):
		self.position = position 
		self.x = self.position[0]
		self.y = self.position[1]

	def __add__(self, other): 
		if isinstance(other, self.__class__):
			_x, _y = other.position
			return (
				self.x + _x, 
				self.y + _y)	
		else: 
			_x, _y = other
			return (
				self.x + _x, 
				self.y + _y)	

	def __radd__(self, position):
		return self.__add__(position)	

	def __mul__(self, other): 
		return Position((
			self.x * other, 
			self.y * other
			))

	def __eq__(self, other):
		if isinstance(other, self.__class__):
			return self.position == other.position
		else:
			return self.position == other

	def __str__(self): 
		return str(self.position)


class Rook(ChessPiece): 
	def __init__(self, *args): 
		ChessPiece.__init__(self, *args)
		self.valid_moves = self.build_move_list()

	def is_valid_move(self, title, board): 
		calulated_moves = self.calulate_moves(self.valid_moves)
		if not self.base_conditions_met(tile, calulated_moves):
			return False
		return True 
		
		v = self.get_vector(tile)
		distance_to_piece = v.magnitude()
		heading = v.discrete_normalize()

		for i in range(1, int(distance_to_piece) -1):
			_tile = board.get_tile_at(self.position + (heading * i))
			print _tile
			if _tile.is_occupied:
				return False

	def build_move_list(self): 
		# (0,1), (1,0), (0,-1), (-1,0) # Directions
		return list(chain(
			imap(lambda x: (0,x), xrange(1,8)),
			imap(lambda x: (x,0), xrange(1,8)),
			imap(lambda x: (0,x), xrange(8,0,-1)),
			imap(lambda x: (x,0), xrange(8,0,-1))
			))

class Knight(ChessPiece):
	def __init__(self, *args): 
		ChessPiece.__init__(self, *args)
		self.valid_moves = self.build_move_list()

	def is_valid_move(self, tile, board): 
		calulated_moves = self.calulate_moves(self.valid_moves)
		if not self.base_conditions_met(tile, calulated_moves):
			return False
		return True 

	def build_move_list(self):
		return [
			(2,1), (2,-1), (1,2), (-1,2), 
			(-2,1), (-2,-1),(1,-2), (-1,-1)
		]


class Queen(ChessPiece): 
	def __init__(self, *args): 
		ChessPiece.__init__(self, *args)
		self.valid_moves = self.build_move_list()

	def is_valid_move(self, tile, board): 
		calulated_moves = self.calulate_moves(self.valid_moves)
		if not self.base_conditions_met(tile, calulated_moves):
			return False

		v = self.get_vector(tile)
		distance_to_piece = v.magnitude()
		heading = v.discrete_normalize()

		for i in range(1, int(distance_to_piece) -1):
			_tile = board.get_tile_at(self.position + (heading * i))
			print _tile
			if _tile.is_occupied:
				return False


	def build_move_list(self): 
		# directions
		# (0,1), (1,1), (1,0), (1,-1), 
		# (0,-1), (-1,-1), (-1, 0)
		return list(chain(
			imap(lambda x: (0,x), range(1,8)),
			imap(lambda x: (x,x), range(1,8)),
			imap(lambda x: (x,0), range(1,8)),
			imap(lambda x: (x,0), izip(range(1,8), range(8,0,-1))),
			imap(lambda x: (0,x), range(8,0,-1)),
			imap(lambda x: (x,x), range(8,0,-1)),
			imap(lambda x: (x,0), range(8,0,-1))
		))


class King(ChessPiece): 
	def __init__(self, *args): 
		ChessPiece.__init__(self, *args)
		self.valid_moves = self.build_move_list()

	def is_valid_move(self, tile, board): 
		calulated_moves = self.calulate_moves(self.valid_moves)
		if not self.base_conditions_met(tile, calulated_moves):
			return False

		# I believe the King can do whatever 
		# the hell it wants, to as long as 
		# the base conditions are met, we should be good. 
		return True 

	def build_move_list(self): 
		return [
			(0,1), (1,1), (1,0), (1,-1), 
			(0,-1), (-1,-1), (-1, 0)
		]



		
class Bishop(ChessPiece): 
	def __init__(self, *args): 
		ChessPiece.__init__(self, *args)
		self.valid_moves = self.build_move_list()

	def is_valid_move(self, tile, board):
		calulated_moves = self.calulate_moves()
		if tile.position not in calulated_moves: 
			print 'not in calc moves'
			return False

		if tile.piece.color == self.color: 
			print 'Same color. Cannot move'
			return False 

		v = self.get_vector(tile)
		distance_to_piece = v.magnitude()
		heading = v.discrete_normalize()

		# run through all the squares leading up to the 
		# tile in question to make sure nothing else is in 
		# the way. 
		for i in range(1, int(distance_to_piece) -1):
			_tile = board.get_tile_at(self.position + (heading * i))
			print _tile
			if _tile.is_occupied:
				return False

	def get_vector(self, other):
		return Vector(other.position, self.position)

	def build_move_list(self):
		return list(chain(
			imap(lambda x: (x,x), range(8)),
			imap(lambda x: (x,x), range(0,-8, -1)),
			imap(lambda x: x, izip(range(8), range(0,-8, -1))),
			imap(lambda x: x, izip(range(0,-8, -1), range(8))),
			))

	def calulate_moves(self):
		calulated_moves = imap(lambda x: self.position + x, self.valid_moves)
		# Make sure none if the moves are off the board. 
		return filter(lambda x: x[0]>=0 and x[1]>=0 
						and x[0] < 8 and x[1] < 8, calulated_moves)

class Pawn(ChessPiece): 
	def __init__(self, *args): 
		ChessPiece.__init__(self, *args)
		self.valid_moves = self.build_move_list()
		# self.direction = UP if self.color == 'w' else DOWN
		# print self.x, self.y

	def is_valid_move(self, tile, board):
		calulated_moves = self.calulate_moves()
		# print calulated_moves
		# print tile.position
		if tile.position not in calulated_moves: 
			print 'not in calc moves'
			return False

		if tile.piece is not None and self.piece.color == self.color: 
			print 'Same color. Cannot move'
			return False 

		attack_angle = self.get_attack_angle(tile)
		if attack_angle != 45 and not tile.is_occupied: 
			print 'Tile is free. Moving piece'
			return True
		
		# Moving an angle to capture something
		if tile.is_occupied and attack_angle == 45: 
			return True 
		return False

	def get_attack_angle(self, other_piece):
		v = Vector(other_piece.position, self.position) 
		return abs(int(v.angle()))


	def build_move_list(self): 
		direction = (Position((-1,0)) 
					if self.color == 'w' 
					else Position((1,0))) 
		moves = [
			Position(direction + (0,0)), # one tile 'up' 
			Position(direction + (0,1)), # right diagonal (taking an oponent)
			Position(direction + (0,-1)) # left  diagonal (taking an oponent)
		]

		if self.in_start_position(): 
			# up two tiles. 
			moves.append(Position(direction + direction)) 
		return moves

	def calulate_moves(self):
		calulated_moves = imap(lambda x: self.position + x, self.valid_moves)

		# Make sure none if the moves are off the board. 
		return filter(lambda x: x[0]>=0 and x[1]>=0, calulated_moves)


	def in_start_position(self):
		if self.color == 'w':
			return True if self.position.x == 6 else False 
		return True if self.position.x == 1 else False 


def flatten(movelist): 
	return ''.join(movelist.replace('\n', ' ').split())	

def pairwise(iterable):
	''' Consume the same iterator in pairs'''
	a = iter(iterable)
	return itertools.imap(lambda x: (x, next(a)), a)

def normalize_moves(moves): 
	def normalize(move): 
		_col, _row = move 
		row = abs(int(_row) - 8)
		col = letters.index(_col)
		return (row, col)
	letters = 'a,b,c,d,e,f,g,h'.split(',')
	return map(normalize, pairwise(moves))
			
bishop = Bishop('w', 3,4)
# test_tile = Tile(5,1, Pawn('w', 5,1))
test_tile = Tile(5,1, Pawn('b', 5,1))

print bishop.calulate_moves()
# print pawn.valid_move(test_tile)


with open('simple_moves.txt') as f: 
	data = f.read()
print '=' * 30
moves = normalize_moves(flatten(data))


cb = ChessBoard()

for move in pairwise(moves): 
	start_pos, end_pos = move 
	tile_a = cb.get_tile_at(start_pos)
	tile_b = cb.get_tile_at(end_pos)

	# print tile_a, tile_b
	if tile_a.is_occupied and tile_a.piece.is_valid_move(tile_b, cb):
		print "VALID"
	else:
		print "INVALID"
	print 



