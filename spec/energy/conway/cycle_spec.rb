require 'spec_helper'
require 'energy/conway/cycle'
require 'energy/conway/grid'

RSpec.describe Energy::Conway::Cycle do
  let(:cycle) { described_class.new(grid) }

  context 'when no active cubes' do
    let(:grid) { Energy::Conway::Grid.new(3) }

    it 'cycle does not produce cubes' do
      cycle.advance
      expect(grid.active_cubes.count).to eq(0)
    end
  end

  context 'when active cubes ready for growth' do
    let(:grid) { Energy::Conway::Grid.new(3) }

    before do
      grid.set_state(true, [2, 2, 2])
      grid.set_state(true, [2, 1, 2])
      grid.set_state(true, [1, 2, 2])
    end

    it 'cycle does not produce cubes' do
      cycle.advance
      expect(grid.active_cubes.count).to eq(12)
    end
  end

  describe 'flat scenario' do
    let(:grid) { Energy::Conway::Grid.new(2) }
    before do
      grid.initialize_from_plane(%w[.#. ..# ###].map { |line| line.split('') }, [])
    end

    it 'correctly evolves' do
      6.times { cycle.advance }
      expect(grid.active_cubes.count).to eq(5)
    end
  end

  describe '3d scenario' do
    let(:grid) { Energy::Conway::Grid.new(3) }
    before do
      grid.initialize_from_plane(%w[.#. ..# ###].map { |line| line.split('') }, [0])
    end

    it 'correctly evolves' do
      6.times { cycle.advance }
      expect(grid.active_cubes.count).to eq(112)
    end
  end

  describe '4d scenario' do
    let(:grid) { Energy::Conway::Grid.new(4) }
    before do
      grid.initialize_from_plane(%w[.#. ..# ###].map { |line| line.split('') }, [0, 0])
    end

    it 'correctly evolves' do
      6.times { cycle.advance }
      expect(grid.active_cubes.count).to eq(848)
    end
  end
end