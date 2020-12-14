require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/airlines/tickets_scanner'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

tickets = input_reader.all_lines.read
info "Processing #{tickets.length} tickets"

scanner = Airlines::TicketsScanner.new

seats = tickets.map { |ticket| scanner.seat_id(ticket) }
max_seat = seats.max
info "Max seat id is: #{max_seat}"

seats_map = Hash[seats.map { |seat_id| [seat_id, true] }]
missing_seats = max_seat.times.select { |seat| !seats_map[seat] }
my_seat = missing_seats.find { |seat| seats_map[seat - 1] && seats_map[seat + 1] }
info "My seat id is: #{my_seat}"
