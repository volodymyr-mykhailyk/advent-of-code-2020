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

valid_tickets = tickets.select { |ticket| ticket.all? { |field| conditions.any? { |condition| condition.match?(field) } } }
valid_tickets.push(my_ticket)
info "Number of valid tickets: #{valid_tickets.count}"

valid_tickets.each do |ticket|
  ticket.each.with_index do |field, index|
    conditions.each { |condition| condition.guess_position(field, index) }
  end
end

iteration = 0
while conditions.any?(&:multivariant?) do
  info "Guessing positions: #{iteration += 1}"
  obvious_positions = conditions.reject(&:multivariant?)
  multivariant_positions = conditions.select(&:multivariant?)
  multivariant_positions.each { |condition| obvious_positions.each { |obvious_condition| condition.remove_positions(obvious_condition.position) } }
end
info "All conditions are guessed: #{conditions.map(&:position)}"

departure_conditions = conditions.select { |condition| condition.is?('departure') }
departure_fields = departure_conditions.map { |condition| my_ticket[condition.position.first] }
puts departure_fields.count
puts departure_fields.reduce(&:*)
