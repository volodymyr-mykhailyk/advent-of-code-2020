require 'spec_helper'
require 'energy/conway/grid'

RSpec.describe Energy::Conway::Grid do
  let(:grid) { described_class.new(4) }

  it 'has all empty layers on init' do
    expect(grid.active_layers.to_a).to be_empty
  end

  it 'returns active layer' do
    grid.set_active(2, 2, 2)
    expect(grid.active_layers.to_a).not_to be_empty
  end

  describe '#active_cubes' do
    it 'empty without active cubes' do
      expect(grid.active_cubes.count).to eq(0)
    end

    it 'returns active cubes' do
      grid.set_active(2, 2, 2)
      grid.set_active(2, 1, 2)
      expect(grid.active_cubes.count).to eq(2)
    end
  end

  describe '#activity_layers' do
    it 'empty without active cubes' do
      expect(grid.activity_layers.to_a).to be_empty
    end

    it 'returns neighbor layers' do
      grid.set_active(2, 2, 2)
      expect(grid.activity_layers.to_a.count).to eq(3)
    end
  end

  describe "#neighbor_cubes_around" do
    it 'returns 26 cubes' do
      cube = grid.cube_at(2, 2, 2)
      expect(grid.neighbor_cubes_around(cube).uniq.count).to eq(26)
    end

    it 'does not include current' do
      cube = grid.cube_at(2, 2, 2)
      expect(grid.neighbor_cubes_around(cube)).to_not include(cube)
    end
  end
end