require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/entertainment/crab_cups'
require_relative '../../lib/entertainment/crab_cups_optimized'
require 'benchmark'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

cups = input_reader.one_line.split_with('').to_integer.read

info "Playing Game of Crab Cups with #{cups.inspect} sequence"

game = Entertainment::CrabCups.new(cups)
game.play_until(100)

info "Result cup labels: #{game.cup_labels}"


full_cups = cups + (10..1_000_000).map(&:to_i)
full_game = Entertainment::CrabCups.new(full_cups)
optimized_game = Entertainment::CrabCupsOptimized.new(full_cups)

info "Playing full Game of Crab Cups with #{full_cups.count} cups"

puts Benchmark.measure { full_game.play_until(10) }
puts Benchmark.measure { optimized_game.play_until(10) }

# starts_index = full_game.cups.index(1)
# stars_result = full_game.cups[starts_index + 1] + full_game.cups[starts_index + 2]
# info "Star result: #{stars_result}"
