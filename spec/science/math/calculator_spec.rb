require 'spec_helper'
require 'science/math/calculator'

RSpec.describe Science::Math::Calculator do
  context 'equal operators priorities' do
    let(:parser) { Science::Math::Calculator::EqualPriorityParser.new }

    describe '#result' do
      it 'supports simple sum expression' do
        exp = "2 + 3"
        expect(expression_result(exp)).to eq(5)
      end

      it 'supports simple multiply expression' do
        exp = "2 * 3"
        expect(expression_result(exp)).to eq(6)
      end

      it 'supports simple group expressions' do
        exp = "2 + (3 * 2)"
        expect(expression_result(exp)).to eq(8)
      end

      it 'supports correct priorities' do
        exp = "2 + 3 * 2"
        expect(expression_result(exp)).to eq(10)
      end
    end

    describe 'scenarios' do
      it 'supports example scenario 1' do
        exp = "1 + 2 * 3 + 4 * 5 + 6"
        expect(expression_result(exp)).to eq(71)
      end

      it 'supports example scenario 2' do
        exp = "1 + (2 * 3) + (4 * (5 + 6))"
        expect(expression_result(exp)).to eq(51)
      end

      it 'supports example scenario 3' do
        exp = "2 * 3 + (4 * 5)"
        expect(expression_result(exp)).to eq(26)
      end

      it 'supports example scenario 4' do
        exp = "5 + (8 * 3 + 9 + 3 * 4 * 3)"
        expect(expression_result(exp)).to eq(437)
      end

      it 'supports example scenario 5' do
        exp = "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))"
        expect(expression_result(exp)).to eq(12240)
      end

      it 'supports example scenario 6' do
        exp = "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"
        expect(expression_result(exp)).to eq(13632)
      end
    end
  end

  context 'sum is a king priorities' do
    let(:parser) { Science::Math::Calculator::SumKingParser.new }

    describe '#result' do
      it 'supports simple sum expression' do
        exp = "2 + 3"
        expect(expression_result(exp)).to eq(5)
      end

      it 'supports simple multiply expression' do
        exp = "2 * 3"
        expect(expression_result(exp)).to eq(6)
      end

      it 'supports simple group expressions' do
        exp = "2 + (3 * 2)"
        expect(expression_result(exp)).to eq(8)
      end

      it 'supports correct priorities 1' do
        exp = "2 + 3 * 2"
        expect(expression_result(exp)).to eq(10)
      end

      it 'supports correct priorities 2' do
        exp = "2 * 3 + 2"
        expect(expression_result(exp)).to eq(10)
      end
    end

    describe 'scenarios' do
      it 'supports example scenario 1' do
        exp = "1 + 2 * 3 + 4 * 5 + 6"
        expect(expression_result(exp)).to eq(231)
      end

      it 'supports example scenario 2' do
        exp = "1 + (2 * 3) + (4 * (5 + 6))"
        expect(expression_result(exp)).to eq(51)
      end

      it 'supports example scenario 3' do
        exp = "2 * 3 + (4 * 5)"
        expect(expression_result(exp)).to eq(46)
      end

      it 'supports example scenario 4' do
        exp = "5 + (8 * 3 + 9 + 3 * 4 * 3)"
        expect(expression_result(exp)).to eq(1445)
      end

      it 'supports example scenario 5' do
        exp = "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))"
        expect(expression_result(exp)).to eq(669060)
      end

      it 'supports example scenario 6' do
        exp = "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"
        expect(expression_result(exp)).to eq(23340)
      end
    end
  end

  describe Science::Math::Calculator::Tokenizer do
    let(:tokenizer) { described_class.new }

    it 'returns simple expressions' do
      exp = "2 + 3"
      expect(tokenizer.tokens(exp)).to eq(%w[2 + 3])
    end

    it 'gets simple int' do
      exp = "2 + 3 * 2"
      expect(tokenizer.tokens(exp)).to eq(%w[2 + 3 * 2])
    end

    it 'group around full expression' do
      exp = "(2 + 3)"
      expect(tokenizer.tokens(exp)).to eq([%w[2 + 3]])
    end

    it 'two groups around full expression' do
      exp = "(2 + 3) * (3 + 2)"
      expect(tokenizer.tokens(exp)).to eq([%w[2 + 3], '*', %w[3 + 2]])
    end

    it 'two included groups' do
      exp = "4 + (2 + (3 * 2))"
      expect(tokenizer.tokens(exp)).to eq(['4', '+', ['2', '+', %w[3 * 2]]])
    end
  end

  protected
  def expression_result(exp)
    described_class.new(exp, parser).result
  end
end