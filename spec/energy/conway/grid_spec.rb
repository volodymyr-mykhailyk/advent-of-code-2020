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

    it 'has no activity cubes' do
      expect(grid.activity_cubes.count).to eq(0)
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

    it 'has activity cubes' do
      expect(grid.activity_cubes.count).to eq(9)
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
        puts grid.inspect
      end

      it 'returns correct activity count' do
        expect(grid.activity_cubes.count).to eq(8)
      end

      it 'returns correct cubes count' do
        expect(grid.activity_cubes.map(&:coordinates)).to include([-1, -1], [1, 0], [0, 1])
      end
    end
  end
end