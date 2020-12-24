require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/navigation/hexagonal_grid'

input_reader = Utils::InputReader.new(File.expand_path('input_sample.txt'))

instructions = input_reader.all_lines.read

info "Building tile flor using  #{instructions.count} instructions"

grid = Navigation::HexagonalGrid.new(->(x, y) { false })
navigator = Navigation::HexagonalGrid::Navigator.new(grid)

instructions.each do |path|
  coordinates = navigator.coordinates_via(path)
  grid.update_at(coordinates, !grid.node_at(coordinates))
end

black_tiles = grid.nodes.count(&:itself)

info "Number of black tiles on day 0: #{black_tiles}"

info "Simulating living art for 100 days"

100.times do |day|
  nodes = grid.coordinates
  new_colors = {}
  nodes.each do |coordinate|
    black = grid.node_at(coordinate)
    adjacent_black_tiles = navigator.adjacent_coordinates(coordinate).count { |coord| !!grid.node_at(coord) }
    if black
      new_colors[coordinate] = adjacent_black_tiles == 1 || adjacent_black_tiles == 2
    else
      new_colors[coordinate] = adjacent_black_tiles == 2
    end
  end

  new_colors.each_pair { |coordinate, color| grid.update_at(coordinate, color) }
  puts "Day #{day + 1}: #{grid.nodes.count(&:itself)}"
end


