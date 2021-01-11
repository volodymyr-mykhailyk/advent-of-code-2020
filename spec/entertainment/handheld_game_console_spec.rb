require 'spec_helper'
require 'entertainment/handheld_game_console'

describe Entertainment::HandheldGameConsole do
  context 'example scenario' do
    let(:console) do
      instructions = ['nop +0',
                      'acc +1',
                      'jmp +4',
                      'acc +3',
                      'jmp -3',
                      'acc -99',
                      'acc +1',
                      'jmp -4',
                      'acc +6']
      described_class.new(instructions.map { |instruction| instruction.split(' ') })
    end

    it 'have default accumulator' do
      expect(console.accumulator).to eq(0)
    end

    it 'fails with loop' do
      expect(console.run).to be_falsey
    end

    it 'correctly executes code' do
      console.run
      expect(console.accumulator).to eq(5)
    end

    it 'runs in safe mode' do
      expect(console.safe_mode.run).to be_truthy
    end

    it 'calculates accumulator in safe mode' do
      safe_mode = console.safe_mode.tap(&:run)
      expect(safe_mode.accumulator).to eq(8)
    end
  end
end