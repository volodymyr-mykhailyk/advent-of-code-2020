require 'spec_helper'
require 'customs/group_declaration_form'

describe Customs::GroupDeclarationForm do
  describe '#positive_answers' do
    it 'counted for single person' do
      form = described_class.new(['abc'])
      expect(form.positive_answers_list).to eq(%w[a b c])
    end

    it 'counted for multiple people' do
      form = described_class.new(%w[a b c])
      expect(form.positive_answers_list).to eq(%w[a b c])
    end

    it 'counted for multiple people with duplicates' do
      form = described_class.new(%w[abcx abcy abcz])
      expect(form.positive_answers_list).to eq(%w[a b c x y z])
    end
  end
end