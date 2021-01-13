require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/computing/protocols/satellite_communications'

input_reader_rules = Utils::InputReader.new(File.expand_path('input_rules.txt'))
rules = input_reader_rules.all_lines.read
protocol = Computing::Protocols::SatelliteCommunications.new(rules)

input_reader_messages, = Utils::InputReader.new(File.expand_path('input_messages.txt'))
messages = input_reader_messages.all_lines.read

info "Reading #{messages.length} messages"
info "Using #{rules.length} rules to verify"

valid_messages = messages.select.with_index do |message, index|
  info "Processed #{index} messages" if index % 10 == 0
  protocol.valid_message?(message)
end

info "Number of valid messages: #{valid_messages.length}"

info "Modifying rules to have loops"
looped_rules = rules.clone
looped_rules[0] = "8: 42 | 42 8"
looped_rules[1] = "11: 42 31 | 42 11 31"
protocol = Computing::Protocols::SatelliteCommunications.new(looped_rules)

valid_messages = messages.select.with_index do |message, index|
  info "Processed #{index} messages" if index % 10 == 0
  protocol.valid_message?(message)
end

info "Number of valid looped messages: #{valid_messages.length}"

