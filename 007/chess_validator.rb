#!/usr/bin/env ruby

require "./lib/chess_validator"

def usage
  puts "chess_validator.rb <board-filename> <move-filename>"
  exit(1)
end

usage if (ARGV.count != 2)

board_filename, move_filename = ARGV

validator = ChessValidator.new(board_filename)

File.open(move_filename, "r").each do |line|
  from_sq, to_sq = line.scan(/\S+/)
  puts validator.check(from_sq, to_sq)
end
