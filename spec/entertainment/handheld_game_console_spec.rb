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

    it 'stops on loop' do
      expect { console.run }.to raise_error('infinite loop')
    end

    it 'correctly executes code' do
      console.run
    rescue => _
    ensure
      expect(console.accumulator).to eq(5)
    end
  end
end