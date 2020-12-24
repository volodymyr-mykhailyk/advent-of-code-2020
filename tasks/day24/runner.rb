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

info "Number of black tiles on day 0: #{black_tiles}"

info "Simulating living art for 100 days"

def expand_grid(grid, navigator)
  black_tiles = grid.coordinates.select { |coordinate| grid.node_at(coordinate) }
  black_tiles.each { |coordinate| navigator.adjacent_coordinates(coordinate).each { |coords| grid.node_at(coords) } }
end

def apply_grid_changes(grid, new_colors)
  grid.coordinates.each do |coordinate|
    color = new_colors[coordinate]
    color.nil? ? grid.delete_at(coordinate) : grid.update_at(coordinate, color)
  end
end

def calculate_grid_changes(grid, new_colors)
  navigator = Navigation::HexagonalGrid::Navigator.new(grid)

  grid.coordinates.each do |coordinate|
    black = grid.node_at(coordinate)
    adjacent_black_tiles = navigator.adjacent_coordinates(coordinate).count { |coord| !!grid.node_at(coord) }
    if black
      new_colors[coordinate] = adjacent_black_tiles == 1 || adjacent_black_tiles == 2
    else
      color = adjacent_black_tiles == 0 ? nil : adjacent_black_tiles == 2
      new_colors[coordinate] = color
    end
  end
end

100.times do |day|
  new_colors = {}
  expand_grid(grid, navigator)
  calculate_grid_changes(grid, new_colors)

  apply_grid_changes(grid, new_colors)
  puts "Day #{day + 1}: #{grid.nodes.count(&:itself)}"
end

black_tiles = grid.nodes.count(&:itself)
info "Number of black tiles on day 100: #{black_tiles}"
