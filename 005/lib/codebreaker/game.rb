require 'pry'

module Codebreaker
  class Game
    def initialize(output, board)
      @output, @board = output, board
    end

    def start(moves)
      File.open(moves, 'r').each_line do |line|
        piece_move = line.split(' ')
        piece = select_chess_piece(piece_move[0])
        black_or_white = piece[0]
        type_of_piece = piece[1]

        target_piece = select_chess_piece(piece_move[1])
        target_black_or_white = target_piece[0]

        pawn(black_or_white, piece_move[0], piece_move[1], target_black_or_white) if type_of_piece == 'P'
        knight(black_or_white, piece_move[0], piece_move[1], target_black_or_white) if type_of_piece == 'N'
      end
    end


    def select_chess_piece(spot)
      piece = ''
      column_map = {a: 0, b: 1, c: 2, d: 3, e: 4, f: 5, g: 6, h: 7}
      File.open(@board, 'r').each_line.with_index do |line, index|
        if (index+1).to_s == spot[1]
          columns = line.split(' ')
          board_spot = columns[column_map[spot[0].to_sym]]
          piece = board_spot
        end
      end
      piece
    end


    def pawn(color, start_position, end_position, target_black_or_white)
      output = 'ILLEGAL'
      if color == 'b'
        if start_position[0] == end_position[0]
          if start_position[1].to_i + 1 == end_position[1].to_i && target_black_or_white == '-'
            output = 'LEGAL'
          elsif start_position[1].to_i + 2 == end_position[1].to_i && target_black_or_white == '-'
            output = 'LEGAL'
          end

          #move diagonally
        elsif start_position[0][0].ord + 1 == end_position[0][0].ord || start_position[0][0].ord - 1 == end_position[0][0].ord
          if start_position[1].to_i + 1 == end_position[1].to_i && target_black_or_white == 'w'
            output = 'LEGAL'
          end
        end


      elsif color == 'w'
        if start_position[0] == end_position[0]
          if start_position[1].to_i - 1 == end_position[1].to_i && target_black_or_white == '-'
            output = 'LEGAL'
          elsif start_position[1].to_i - 2 == end_position[1].to_i && target_black_or_white == '-'
            output = 'LEGAL'
          end

          #move diagonally
        elsif start_position[0][0].ord + 1 == end_position[0][0].ord || start_position[0][0].ord - 1 == end_position[0][0].ord
          if start_position[1].to_i - 1 == end_position[1].to_i && target_black_or_white == 'w'
            output = 'LEGAL'
          end
        end
      end
      @output.puts output
    end


    def knight(color, start_position, end_position, target_black_or_white)
      output = 'ILLEGAL'
#binding.pry
      # move 1 horizontal and 2 vertical
      if start_position[0][0].ord + 1 == end_position[0][0].ord || start_position[0][0].ord - 1 == end_position[0][0].ord
        if start_position[1].to_i + 2 == end_position[1].to_i || start_position[1].to_i - 2 == end_position[1].to_i
          if target_black_or_white != color
            output = 'LEGAL'
          end
        end
      end

      # move 2 horizontal and 1 vertical
      if start_position[0][0].ord + 2 == end_position[0][0].ord || start_position[0][0].ord - 2 == end_position[0][0].ord
        if start_position[1].to_i + 1 == end_position[1].to_i || start_position[1].to_i - 1 == end_position[1].to_i
          if target_black_or_white != color
            output = 'LEGAL'
          end
        end
      end

      @output.puts output

    end


  end
end