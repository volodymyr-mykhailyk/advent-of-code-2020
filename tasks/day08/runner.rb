require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/entertainment/handheld_game_console'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

instructions = input_reader.all_lines.split_with(' ').read
info "Simulating boot code from #{instructions.length} instructions"

console = Entertainment::HandheldGameConsole.new(instructions)
info "Boot sequence executed: #{console.run}"
info "Accumulator after run: #{console.accumulator}"

safe_mode = console.safe_mode
info "Running in safe mode"
info "Boot sequence executed: #{safe_mode.run}"
info "Accumulator after run: #{safe_mode.accumulator}"
