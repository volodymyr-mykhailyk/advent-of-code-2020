require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/travel/train/ticket_field'

conditions_reader = Utils::InputReader.new(File.expand_path('input_conditions.txt'))
tickets_reader = Utils::InputReader.new(File.expand_path('input_tickets.txt'))

my_ticket = [109, 199, 223, 179, 97, 227, 197, 151, 73, 79, 211, 181, 71, 139, 53, 149, 137, 191, 83, 193]
conditions = conditions_reader.all_lines.split_with(': ').read.map { |condition| Travel::Train::TicketField.new(*condition) }
tickets = tickets_reader.all_lines.split_with(',').read.map { |ticket| ticket.map(&:to_i) }
info "Decoding #{tickets.count} tickets over #{conditions.count} conditions"

invalid_checksum = tickets.sum do |ticket|
  ticket.select do |field|
    conditions.none? { |condition| condition.match?(field) }
  end.sum
end

info "Invalid checksum #{invalid_checksum}"

