require 'spec_helper'
require 'computing/protocols/xmas'

RSpec.describe Computing::Protocols::Xmas do
  let(:protocol) { described_class.new([35, 20, 15, 25, 47]) }

  context 'simple interface' do

  end
  it 'processing correct next number' do
    expect { protocol.process_next(35 + 47) }.not_to raise_error
  end

  it 'limits search to initial size' do
    protocol.process_next(40)
    expect { protocol.process_next(35 + 47) }.to raise_error('invalid sequence')
  end

  it 'raising error on invalid' do
    expect { protocol.process_next(2) }.to raise_error('invalid sequence')
  end

  describe 'Decipher' do
    let(:input) { [35, 20, 15, 25, 47, 40, 62, 55, 65, 95, 102, 117, 150, 182, 127, 219, 299, 277, 309, 576] }
    let(:decipher) { Computing::Protocols::Xmas::Decipher.new(input, 5) }

    it 'returns correct invalid number' do
      decipher.crack_protocol
      expect(decipher.invalid_number).to eq(127)
    end

    it 'returns encryption weakness' do
      decipher.crack_protocol
      expect(decipher.encryption_weakness).to eq(62)
    end
  end
end