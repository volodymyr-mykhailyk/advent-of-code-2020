require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/computing/protocols/satellite_communications'

input_reader_rules = Utils::InputReader.new(File.expand_path('input_rules.txt'))
rules = input_reader_rules.all_lines.read

input_reader_messages, = Utils::InputReader.new(File.expand_path('input_messages.txt'))
messages = input_reader_messages.all_lines.read

protocol = Computing::Protocols::SatelliteCommunications.new(rules)

info "Reading #{messages.length} messages"
info "Using #{rules.length} rules to verify"

valid_messages = messages.select { |message| protocol.valid_message?(message) }
info "Number of valid messages: #{valid_messages.length}"

