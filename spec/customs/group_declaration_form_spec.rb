require 'spec_helper'
require 'customs/group_declaration_form'

describe Customs::GroupDeclarationForm do
  describe '#all_positive_answers' do
    it 'counted for single person' do
      form = described_class.new(['abc'])
      expect(form.all_positive_answers).to eq(%w[a b c])
    end

    it 'counted for multiple people' do
      form = described_class.new(%w[a b c])
      expect(form.all_positive_answers).to eq(%w[a b c])
    end

    it 'counted for multiple people with duplicates' do
      form = described_class.new(%w[abcx abcy abcz])
      expect(form.all_positive_answers).to eq(%w[a b c x y z])
    end
  end

  describe '#everyone_positive_answers' do
    it 'counted for single person' do
      form = described_class.new(['abc'])
      expect(form.everyone_positive_answers).to eq(%w[a b c])
    end

    it 'counted for multiple people' do
      form = described_class.new(%w[ax ba ac])
      expect(form.everyone_positive_answers).to eq(%w[a])
    end

    it 'counted for multiple people with duplicates' do
      form = described_class.new(%w[abcx abcy abcz])
      expect(form.everyone_positive_answers).to eq(%w[a b c])
    end
  end
end