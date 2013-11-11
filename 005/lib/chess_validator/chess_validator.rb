# require "chess_validator/version"
# to run spec, use: rspec --format doc

module ChessValidator
  class Validate
    def initialize(input_board, input_moves)
      @output = input_board.to_s
    end

    def start
      puts 'Welcome to Chess Validator'
    end

    def pawn
      @output.puts 'ILLEGAL'
    end
  end
end

