require 'rspec'
require 'computing/docking/bitmask'

describe Computing::Docking::Bitmask do
  describe '#apply_to' do
    let(:bitmap) { described_class.new('XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X') }
    it 'applies bitmask to 0' do
      expect(bitmap.apply_to(0)).to eq(64)
    end

    it 'applies bitmask without changes' do
      expect(bitmap.apply_to(101)).to eq(101)
    end

    it 'applies bitmask to numbers' do
      expect(bitmap.apply_to(11)).to eq(73)
    end

    it 'applies zero leading mask' do
      bitmask = described_class.new('0X')
      expect(bitmask.apply_to(3)).to eq(1)
    end
  end
end