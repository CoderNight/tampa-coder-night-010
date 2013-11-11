# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chess_validator/version'
require 'rbconfig'

Gem::Specification.new do |spec|
  spec.name          = "chess_validator"
  spec.version       = ChessValidator::VERSION
  spec.authors       = ["Rob Daniels"]
  spec.email         = ["rob@danielscorporation.com"]
  spec.description   = 'A company that specializes in building mediocre games for social networking platforms has offered you a fistful of cash in the form of a one percent profit sharing agreement and free pizza. All you need to do is prove that you''re the kind of rockstar programmer they need on staff by taking a simple test. Because you know that you''re exactly the sort of ninja frogman devops superstar that they''re looking for, you decide to give it a shot. Your task is to create a Chess move validator: given a list of moves and a board, you are expected to determine whether each move is LEGAL or ILLEGAL. Some sample input and output files are provided to make this task a little bit easier for you to work on.'
  spec.summary       = 'Chess move validator: given a list of moves and a board, this program determines whether each move is LEGAL or ILLEGAL'
  spec.homepage      = "http://www.puzzlenode.com/puzzles/13-chess-validator"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "guard-rspec"

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-remote'
  spec.add_development_dependency 'pry-stack_explorer'
  spec.add_development_dependency 'pry-debugger'

  # spec.add_development_dependency "wdm", '>= 0.1.0' if RbConfig::CONFIG['target_os'] =~ /mswin|mingw|cygwin/i
end
