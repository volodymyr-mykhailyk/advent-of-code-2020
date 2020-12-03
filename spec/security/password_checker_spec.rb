require 'spec_helper'
require 'security/password_checker'

RSpec.describe Security::PasswordChecker do
  subject(:checker) { described_class.new }

  describe 'sled_rental passwords' do
    it 'verifies valid password' do
      expect(checker.valid_for_sled_rental?('1-3 a', 'abcde')).to be_truthy
    end

    it 'verifies invalid password' do
      expect(checker.valid_for_sled_rental?('1-3 b', 'cdefg')).to be_falsey
    end

    it 'verifies valid password' do
      expect(checker.valid_for_sled_rental?('2-9 c', 'ccccccccc')).to be_truthy
    end
  end

  describe 'toboggan_authentication passwords' do
    it 'verifies valid password' do
      expect(checker.valid_for_toboggan_authentication?('1-3 a', 'abcde')).to be_truthy
    end

    it 'verifies invalid password' do
      expect(checker.valid_for_toboggan_authentication?('1-3 b', 'cdefg')).to be_falsey
    end

    it 'verifies invalid password' do
      expect(checker.valid_for_toboggan_authentication?('2-9 c', 'ccccccccc')).to be_falsey
    end

    it 'verifies invalid password' do
      expect(checker.valid_for_toboggan_authentication?('3-6 n', 'kntwpnn')).to be_truthy
    end
  end
end