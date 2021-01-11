require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/entertainment/handheld_game_console'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

instructions = input_reader.all_lines.split_with(' ').read
info "Simulating boot code from #{instructions.length} instructions"

console = Entertainment::HandheldGameConsole.new(instructions)
begin
  console.run
rescue => _
end
accumulator = console.accumulator
info "Accumulator at beginning of loop #{accumulator}"