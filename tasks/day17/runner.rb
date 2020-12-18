require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/energy/conway/grid'
require_relative '../../lib/energy/conway/cycle'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

initial_layer = input_reader.all_lines.split_with('').read
grid = Energy::Conway::Grid.new(3)
grid.initialize_from_plane(initial_layer, [0])
cycle = Energy::Conway::Cycle.new(grid)

info "Simulating conway cube in 3 dimensions"
puts grid
6.times do |i|
  cycle.advance
end
info "Active cubes count: #{grid.active_cubes.count}"

grid = Energy::Conway::Grid.new(5)
grid.initialize_from_plane(initial_layer, [0, 0, 0])
cycle = Energy::Conway::Cycle.new(grid)

info "Simulating conway cube in 4 dimensions"
puts grid
6.times do |i|
  cycle.advance
end
info "Active cubes count: #{grid.active_cubes.count}"
