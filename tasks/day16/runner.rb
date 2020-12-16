require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/travel/trains/ticket_field'
require_relative '../../lib/travel/trains/ticket'
require_relative '../../lib/travel/trains/fields_positioner'

fields_reader = Utils::InputReader.new(File.expand_path('input_conditions.txt'))
tickets_reader = Utils::InputReader.new(File.expand_path('input_tickets.txt'))

field_values = fields_reader.all_lines.split_with(': ').read
ticket_values = tickets_reader.all_lines.split_with(',').read
my_ticket_values = [109, 199, 223, 179, 97, 227, 197, 151, 73, 79, 211, 181, 71, 139, 53, 149, 137, 191, 83, 193]

fields = field_values.map { |condition| Travel::Trains::TicketField.new(*condition) }
tickets = ticket_values.map { |values| Travel::Trains::Ticket.new(fields, values.map(&:to_i)) }
my_ticket = Travel::Trains::Ticket.new(fields, my_ticket_values)

info "Decoding #{tickets.count} tickets over #{fields.count} fields"


validity_checksum = tickets.sum(&:validity_checksum)
info "Invalid tickets checksum: #{validity_checksum}"

valid_tickets = tickets.select(&:valid?).push(my_ticket)
info "Number of valid tickets: #{valid_tickets.count}"

fields_positioner = Travel::Trains::FieldsPositioner.new(fields)
fields_positioner.guess_positions(valid_tickets)

departure_checksum = my_ticket.fields_by_name('departure').reduce(&:*)
info "My Ticket departure checksum: #{departure_checksum}"
