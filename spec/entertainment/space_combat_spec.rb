require 'spec_helper'
require 'entertainment/space_combat'

describe Entertainment::SpaceCombat do
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
      it 'give cards to higher card owner' do
        game = described_class.new([9], [3])
        expect(game.play_game).to eq(0)
        expect(game.winner_score).to eq(21)
        expect(game.player1).to eq([9, 3])
        expect(game.player2).to eq([])
      end
    end

    context 'sample game' do
      it 'correctly determine winner' do
        game = described_class.new([9, 2, 6, 3, 1], [5, 8, 4, 7, 10])
        expect(game.play_game).to eq(1)
        expect(game.winner_score).to eq(306)
        expect(game.player1).to eq([])
        expect(game.player2).to eq([3, 2, 10, 6, 8, 5, 9, 4, 7, 1])
      end
    end

    context 'empty player' do
      it 'does nothing' do
        game = described_class.new([], [10, 2])
        expect(game.play_game).to eq(1)
        expect(game.winner_score).to eq(22)
        expect(game.player1).to eq([])
        expect(game.player2).to eq([10, 2])
      end
    end

    context 'infinite loop' do
      it 'finish as 1st player win' do
        game = described_class.new([43, 19], [2, 29, 14])
        expect(game.play_game).to eq(0)
        expect(game.winner_score).to eq(105)
        expect(game.player1).to eq([43, 19])
        expect(game.player2).to eq([2, 29, 14])
      end
    end
  end
end