require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/navigation/hexagonal_grid'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

instructions = input_reader.all_lines.read

info "Building tile flor using  #{instructions.count} instructions"

grid = Navigation::HexagonalGrid.new(->(x, y) { false })
navigator = Navigation::HexagonalGrid::Navigator.new(grid)

instructions.each do |path|
  coordinates = navigator.coordinates_via(path)
  grid.update_at(coordinates, !grid.node_at(coordinates))
end

black_tiles = grid.nodes.count(&:itself)

info "Number of black tiles: #{black_tiles}"
