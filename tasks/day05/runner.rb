require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/airlines/tickets_scanner'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

tickets = input_reader.all_lines.read
info "Processing #{tickets.length} tickets"

scanner = Airlines::TicketsScanner.new

max_seat_id = tickets.map { |ticket| scanner.seat_id(ticket) }.max
info "Max seat id is: #{max_seat_id}"
