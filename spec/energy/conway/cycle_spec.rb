require 'spec_helper'
require 'energy/conway/cycle'
require 'energy/conway/grid'

RSpec.describe Energy::Conway::Cycle do
  let(:grid) { Energy::Conway::Grid.new(4) }
  let(:cycle) { described_class.new(grid) }

  context 'when no active cubes' do
    it 'cycle does not produce cubes' do
      cycle.advance
      expect(grid.active_cubes.count).to eq(0)
    end
  end

  context 'when active cubes ready for growth' do
    before do
      grid.set_active(2, 2, 2)
      grid.set_active(2, 1, 2)
      grid.set_active(1, 2, 2)
    end

    it 'cycle does not produce cubes' do
      puts grid
      cycle.advance
      puts '---' * 10
      puts grid
    end
  end

  describe 'flat scenario' do
    let(:grid) { Energy::Conway::Grid.new(2) }
    before do
      grid.initialize_from_plane(%w[.#. ..# ###].map { |line| line.split('') }, [])
    end

    it 'correctly evolves' do
      puts grid
      6.times { cycle.advance }
      expect(grid.active_cubes.count).to eq(112)
    end
  end

  describe 'scenarios 0' do
    before do
      grid.initialize_from_plane(%w[.#. ..# ###].map { |line| line.split('') }, 2)
    end

    it 'correctly evolves' do
      6.times { cycle.advance }
      expect(grid.active_cubes.count).to eq(112)
    end
  end
end