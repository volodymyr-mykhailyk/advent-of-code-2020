require 'spec_helper'
require 'computing/protocols/security_doors'

describe Computing::Protocols::SecurityDoors do
  let(:protocol) { described_class.new(7) }

  describe '#loop_size_for' do
    it 'returns correct loop size for 1965712' do
      expect(protocol.loop_size_for(1965712)).to eq(7779516)
    end

    it 'returns correct loop size for 19072108' do
      expect(protocol.loop_size_for(19072108)).to eq(7177897)
    end

    it 'returns correct loop size for 5764801' do
      expect(protocol.loop_size_for(5764801)).to eq(8)
    end

    it 'returns correct loop size for 17807724' do
      expect(protocol.loop_size_for(17807724)).to eq(11)
    end
  end

  describe '#encryption_key' do
    it 'returns correct key for 8 loops' do
      expect(protocol.encryption_key_for(8)).to eq(5764801)
    end

    it 'returns correct key for 11 loops' do
      expect(protocol.encryption_key_for(11)).to eq(17807724)
    end
  end

  describe 'Decipher' do
    let(:decipher) { Computing::Protocols::SecurityDoors::Decipher.new }

    it 'returns correct subject number for card key' do
      # expect(decipher.find_subject_for(5764801)).to eq(7)
    end

    it 'returns correct subject number for door key' do
      # expect(decipher.find_subject_for(17807724)).to eq(7)
    end

    it 'returns correct encryption keys' do
      expect(decipher.find_encryption_keys(7, 5764801, 17807724)).to eq([14897079, 14897079])
    end
  end
end