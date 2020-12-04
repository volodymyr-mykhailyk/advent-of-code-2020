require 'spec_helper'
require 'customs/passport_scanner'

describe Customs::PasswordScanner do
  let(:scanner) { described_class.new }
  let(:passport) do
    {
      ecl: 'gry',
      pid: '860033327',
      eyr: '2020',
      hcl: '#fffffd',
      byr: '1937',
      iyr: '2017',
      cid: '147',
      hgt: '183cm'
    }
  end

  describe '#has_all_fields' do
    it 'returns true for valid passport' do
      expect(scanner.has_all_fields?(passport)).to be_truthy
    end

    it 'returns true for missing optional field' do
      passport.delete(:cid)
      expect(scanner.has_all_fields?(passport)).to be_truthy
    end

    it 'returns false for missing field' do
      passport.delete(:ecl)
      expect(scanner.has_all_fields?(passport)).to be_falsey
    end
  end

  describe '#has_all_valid_fields?' do
    it 'returns true for valid passport' do
      expect(scanner.has_all_valid_fields?(passport)).to be_truthy
    end

    it 'returns false for wrong byr' do
      passport[:byr] = '1919'
      expect(scanner.has_all_valid_fields?(passport)).to be_falsey
    end

    it 'returns false for wrong iyr' do
      passport[:iyr] = '2021'
      expect(scanner.has_all_valid_fields?(passport)).to be_falsey
    end

    it 'returns false for wrong eyr' do
      passport[:eyr] = '2019'
      expect(scanner.has_all_valid_fields?(passport)).to be_falsey
    end

    it 'returns false for wrong eyr' do
      passport[:hgt] = '190in'
      expect(scanner.has_all_valid_fields?(passport)).to be_falsey
    end

    it 'returns false for wrong hcl' do
      passport[:hcl] = '#123abz'
      expect(scanner.has_all_valid_fields?(passport)).to be_falsey
    end

    it 'returns false for wrong ecl' do
      passport[:ecl] = 'wat'
      expect(scanner.has_all_valid_fields?(passport)).to be_falsey
    end
    
    it 'returns false for wrong pid' do
      passport[:pid] = '0123456789'
      expect(scanner.has_all_valid_fields?(passport)).to be_falsey
    end
  end
end