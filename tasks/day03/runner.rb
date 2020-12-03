require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/navigation/map'
require_relative '../../lib/navigation/repeatable_map'
require_relative '../../lib/navigation/map_element'
require_relative '../../lib/navigation/trajectory_mapper'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

input = input_reader.all_lines.read
elements = { '#' => Navigation::MapElement.new('#'), '.' => Navigation::MapElement.new('.') }
map = Navigation::RepeatableMap.new(Navigation::Map.new(input, elements))
info "Finding trajectory on map: [#{map.height}, #{map.width}]"

mapper = Navigation::TrajectoryMapper.new(map)
trajectory_trees = mapper.calculate_trajectory(3, 1)

info "Number of trees on [3,1] trajectory: #{trajectory_trees}"
