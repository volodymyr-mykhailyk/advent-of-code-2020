require 'spec_helper'
require 'entertainment/recursive_space_combat'

describe Entertainment::RecursiveSpaceCombat do
  let(:player1) { [9, 2, 6, 3, 1] }
  let(:player2) { [5, 8, 4, 7, 10] }
  let(:game) { described_class.new(player1, player2) }

  describe '#play_round' do
    context 'player1 has winning card' do
      it 'give cards to player1' do
        game = described_class.new([9], [3])
        game.play_round
        expect(game.player1).to eq([9, 3])
        expect(game.player2).to eq([])
      end

      it 'give cards to player2' do
        game = described_class.new([1], [10])
        game.play_round
        expect(game.player1).to eq([])
        expect(game.player2).to eq([10, 1])
      end

      it 'does nothing when one empty' do
        game = described_class.new([], [10, 2])
        game.play_round
        expect(game.player1).to eq([])
        expect(game.player2).to eq([10, 2])
      end
    end
  end

  describe '#play game' do
    context 'one round' do
      it 'give win to higher card owner' do
        game = described_class.new([9], [3])
        expect(game.play_game).to eq(0)
        expect(game.winner_score).to eq(21)
        expect(game.player1).to eq([9, 3])
        expect(game.player2).to eq([])
      end
    end

    context 'sample game' do
      it 'give win to correct player' do
        game = described_class.new([9, 2, 6, 3, 1], [5, 8, 4, 7, 10])
        expect(game.play_game(false)).to eq(1)
        expect(game.winner_score).to eq(291)
        expect(game.player1).to eq([])
        expect(game.player2).to eq([7, 5, 6, 2, 4, 1, 10, 8, 9, 3])
      end
    end
  end
end