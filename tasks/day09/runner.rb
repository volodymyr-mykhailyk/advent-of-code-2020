require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/computing/protocols/xmas'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

numbers = input_reader.all_lines.to_integer.read
preamble = numbers.shift(25)
info "Processing xmas data stack with #{numbers.length} data points"

protocol = Computing::Protocols::Xmas.new(preamble)
numbers.each do |number|
  protocol.process_next(number)
rescue => _
  info "First Invalid number: #{number}"
  break
end

