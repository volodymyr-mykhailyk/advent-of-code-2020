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

  context 'example scenario 2' do
    let(:protocol) do
      rules = ['42: 9 14 | 10 1',
               '9: 14 27 | 1 26',
               '10: 23 14 | 28 1',
               '1: "a"',
               '11: 42 31 | 42 11 31',
               '5: 1 14 | 15 1',
               '19: 14 1 | 14 14',
               '12: 24 14 | 19 1',
               '16: 15 1 | 14 14',
               '31: 14 17 | 1 13',
               '6: 14 14 | 1 14',
               '2: 1 24 | 14 4',
               '0: 8 11',
               '13: 14 3 | 1 12',
               '15: 1 | 14',
               '17: 14 2 | 1 7',
               '23: 25 1 | 22 14',
               '28: 16 1',
               '4: 1 1',
               '20: 14 14 | 1 15',
               '3: 5 14 | 16 1',
               '27: 1 6 | 14 18',
               '14: "b"',
               '21: 14 1 | 1 14',
               '25: 1 1 | 1 14',
               '22: 14 14',
               '8: 42 | 42 8',
               '26: 14 22 | 1 20',
               '18: 15 15',
               '7: 14 5 | 1 21',
               '24: 14 1']
      described_class.new(rules)
    end

    it 'matches correct messages' do
      expect(protocol.valid_message?('bbabbbbaabaabba')).to be_truthy
      expect(protocol.valid_message?('babbbbaabbbbbabbbbbbaabaaabaaa')).to be_truthy
      expect(protocol.valid_message?('babbbbaabbbbbabbbbbbaabaaabaaa')).to be_truthy
      expect(protocol.valid_message?('aaabbbbbbaaaabaababaabababbabaaabbababababaaa')).to be_truthy
      expect(protocol.valid_message?('bbbbbbbaaaabbbbaaabbabaaa')).to be_truthy
      expect(protocol.valid_message?('bbbababbbbaaaaaaaabbababaaababaabab')).to be_truthy
      expect(protocol.valid_message?('ababaaaaaabaaab')).to be_truthy
      expect(protocol.valid_message?('ababaaaaabbbaba')).to be_truthy
      expect(protocol.valid_message?('baabbaaaabbaaaababbaababb')).to be_truthy
      expect(protocol.valid_message?('abbbbabbbbaaaababbbbbbaaaababb')).to be_truthy
      expect(protocol.valid_message?('aaaaabbaabaaaaababaa')).to be_truthy
      expect(protocol.valid_message?('aaaabbaabbaaaaaaabbbabbbaaabbaabaaa')).to be_truthy
      expect(protocol.valid_message?('aabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba')).to be_truthy
    end

    it 'not matches correct messages' do
      expect(protocol.valid_message?('aaaabbaaaabbaaa')).to be_falsey
    end
  end
end