require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/energy/conway/grid'
require_relative '../../lib/energy/conway/cycle'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

initial_layer = input_reader.all_lines.split_with('').read
grid = Energy::Conway::Grid.new(20)
grid.initialize_layer(initial_layer, 20)
cycle = Energy::Conway::Cycle.new(grid)

info "Simulating conway cube of size: 20"
puts grid
6.times do |i|
  cycle.advance
end
info "Active cubes count: #{grid.active_cubes.count}"