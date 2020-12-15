require 'rspec'
require 'entertainment/memory_game'

describe Entertainment::MemoryGame do
  context 'sequence 0,3,6' do
    let(:game) { Entertainment::MemoryGame.new([0, 3, 6]) }

    it "has correct number on turn 10" do
      game.advance_to(10)
      expect(game.current_number).to eq(0)
    end

    it "has correct number on turn 2020" do
      game.advance_to(2020)
      expect(game.current_number).to eq(436)
    end
  end

  context 'sequence 1,3,2' do
    let(:game) { Entertainment::MemoryGame.new([1,3,2]) }

    it "has correct number on turn 2020" do
      game.advance_to(2020)
      expect(game.current_number).to eq(1)
    end
  end

  context 'sequence 2,1,3' do
    let(:game) { Entertainment::MemoryGame.new([2,1,3]) }

    it "has correct number on turn 2020" do
      game.advance_to(2020)
      expect(game.current_number).to eq(10)
    end
  end

  context 'sequence 1,2,3' do
    let(:game) { Entertainment::MemoryGame.new([1,2,3]) }

    it "has correct number on turn 2020" do
      game.advance_to(2020)
      expect(game.current_number).to eq(27)
    end
  end

  context 'sequence 2,3,1' do
    let(:game) { Entertainment::MemoryGame.new([2,3,1]) }

    it "has correct number on turn 2020" do
      game.advance_to(2020)
      expect(game.current_number).to eq(78)
    end
  end

  context 'sequence 3,2,1' do
    let(:game) { Entertainment::MemoryGame.new([3,2,1]) }

    it "has correct number on turn 2020" do
      game.advance_to(2020)
      expect(game.current_number).to eq(438)
    end
  end

  context 'sequence 3,1,2' do
    let(:game) { Entertainment::MemoryGame.new([3,1,2]) }

    it "has correct number on turn 2020" do
      game.advance_to(2020)
      expect(game.current_number).to eq(1836)
    end
  end
end