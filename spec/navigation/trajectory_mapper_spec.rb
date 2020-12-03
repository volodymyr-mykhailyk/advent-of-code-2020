require 'spec_helper'
require 'navigation/trajectory_mapper'
require 'navigation/map'
require 'navigation/map_element'

RSpec.describe Navigation::TrajectoryMapper do
  MAP_LINES = %w[
    ..##
    #...
    ##..
]
  let(:elements) { { '#' => Navigation::MapElement.new('#'), '.' => Navigation::MapElement.new('.') } }
  let(:map) { Navigation::Map.new(MAP_LINES, elements) }
  let(:mapper) { described_class.new(map) }

  it 'counts trees on empty trajectory empty' do
    expect(mapper.calculate_trajectory(1, 1)).to eq(0)
  end

  it 'counts trees on non empty trajectory' do
    expect(mapper.calculate_trajectory(0, 1)).to eq(2)
  end

  it 'goes out of bounds' do
    expect { mapper.calculate_trajectory(3, 1) }.to raise_error('out of bounds')
  end
end