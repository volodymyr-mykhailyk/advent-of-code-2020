require 'spec_helper'
require 'computing/protocols/satellite_communications'

describe Computing::Protocols::SatelliteCommunications do
  context 'example scenario 1' do
    let(:protocol) do
      rules = ['0: 1 2',
               '1: "a"',
               '2: 1 3 | 3 1',
               '3: "b"']
      described_class.new(rules)
    end

    it 'matches correct messages' do
      expect(protocol.valid_message?('aab')).to be_truthy
      expect(protocol.valid_message?('aba')).to be_truthy
    end

    it 'not matches longer messages' do
      expect(protocol.valid_message?('aaba')).to be_falsey
      expect(protocol.valid_message?('abaa')).to be_falsey
    end

    it 'not matches shorter messages' do
      expect(protocol.valid_message?('aa')).to be_falsey
      expect(protocol.valid_message?('ab')).to be_falsey
    end

    it 'not matches invalid messages' do
      expect(protocol.valid_message?('bbb')).to be_falsey
      expect(protocol.valid_message?('aaa')).to be_falsey
    end
  end
end