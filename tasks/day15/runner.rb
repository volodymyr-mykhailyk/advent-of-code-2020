require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/entertainment/memory_game'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

starting_numbers = input_reader.one_line.split_with(',').to_integer.read
info "Playing memory game with: #{starting_numbers.inspect}"

game = Entertainment::MemoryGame.new(starting_numbers)
game.advance_to(2020)
info "Last spoken number on turn 2020th: #{game.current_number}"

game.advance_to(30000000)
info "Last spoken number on turn 30000000th: #{game.current_number}"

