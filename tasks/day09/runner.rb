require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/computing/protocols/xmas'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

numbers = input_reader.all_lines.to_integer.read
info "Processing xmas data stack with #{numbers.length} data points"

decipher = Computing::Protocols::Xmas::Decipher.new(numbers, 25)
decipher.crack_protocol

info "First Invalid number: #{decipher.invalid_number}"
info "Encryption weakness: #{decipher.encryption_weakness}"

