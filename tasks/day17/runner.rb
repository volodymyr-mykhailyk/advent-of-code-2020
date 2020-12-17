require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/energy/conway/grid'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

initial_layer = input_reader.all_lines.split_with('').read
grid = Energy::Conway::Grid.new(20)
grid.initialize_layer(initial_layer, 20)


new_grid = grid.clone
grid.init_cube('#', 0, 0, 20)
puts new_grid
puts grid