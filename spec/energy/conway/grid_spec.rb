require 'spec_helper'
require 'energy/conway/grid'

RSpec.describe Energy::Conway::Grid do
  let(:grid) { described_class.new(3) }

  context 'empty grid' do
    let(:layer) { %w[... ... ...].map { |line| line.split('') } }
    before { grid.initialize_from_plane(layer, [0]) }

    it 'has no active cubes' do
      expect(grid.active_cubes.count).to eq(0)
    end

    it 'has initialized cubes' do
      expect(grid.all_cubes.count).to eq(9)
    end
  end

  context 'sample layer' do
    let(:layer) { %w[.#. ..# ###].map { |line| line.split('') } }
    before { grid.initialize_from_plane(layer, [0]) }

    it 'has active cubes' do
      expect(grid.active_cubes.count).to eq(5)
    end

    it 'has initialized cubes' do
      expect(grid.all_cubes.count).to eq(9)
    end
  end

  describe 'cycle preparation' do
    context '2 dimensions' do
      let(:grid) { described_class.new(2) }
      before do
        grid.set_state(true, [0, 0])
        grid.prepare_cycle
      end

      it 'expand area to include all activity cubes' do
        expect(grid.all_cubes.count).to eq(9)
      end

      it 'returns correct cubes count' do
        expect(grid.all_cubes.map(&:coordinates)).to include([-1, -1], [1, 0], [0, 1])
      end

      it 'not extend corrdinates above active' do
        grid.prepare_cycle
        expect(grid.all_cubes.count).to eq(9)
      end

      it 'respects additional active cubes' do
        grid.set_state(true, [1, 0])
        grid.prepare_cycle
        expect(grid.all_cubes.count).to eq(12)
      end
    end

    context '3 dimensions' do
      let(:grid) { described_class.new(3) }
      before do
        grid.set_state(true, [0, 0, 0])
        grid.prepare_cycle
      end

      it 'expand area to include all activity cubes' do
        expect(grid.all_cubes.count).to eq(27)
      end

      it 'returns correct cubes count' do
        expect(grid.all_cubes.map(&:coordinates)).to include([-1, -1, -1], [1, 0, 0], [1, 0, 1])
      end

      it 'not extend corrdinates above active' do
        grid.prepare_cycle
        expect(grid.all_cubes.count).to eq(27)
      end

      it 'respects additional active cubes' do
        grid.set_state(true, [0, 0, 1])
        grid.prepare_cycle
        expect(grid.all_cubes.count).to eq(36)
      end
    end
  end
end