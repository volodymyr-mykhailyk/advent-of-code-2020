require 'spec_helper'
require 'entertainment/crab_cups'

describe Entertainment::CrabCups do

  context 'sample game' do
    let(:game) { described_class.new([3, 8, 9, 1, 2, 5, 4, 6, 7]) }

    context '1 move' do
      before { game.play_until(1) }

      it 'has correct cup order' do
        expect(game.cups).to eq([3, 2, 8,  9,  1,  5,  4,  6,  7])
      end

      it 'has correct cup labels' do
        expect(game.cup_labels).to eq('54673289')
      end
    end

    context '10 moves' do
      before { game.play_until(10) }

      it 'has correct cup order' do
        expect(game.cups).to eq([5, 8, 3, 7, 4, 1, 9, 2, 6])
      end

      it 'has correct cup labels' do
        expect(game.cup_labels).to eq('92658374')
      end
    end

    context '100 moves' do
      before { game.play_until(100) }

      it 'has correct cup order' do
        expect(game.cups).to eq([2, 9, 1, 6, 7, 3, 8, 4, 5])
      end

      it 'has correct cup labels' do
        expect(game.cup_labels).to eq('67384529')
      end
    end
  end
end