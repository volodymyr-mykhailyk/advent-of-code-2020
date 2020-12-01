require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/accounting/expense_report'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

input = input_reader.all_lines.to_integer.read
info "Finding pair of numbers in input: #{input.length}"

expense_report = Accounting::ExpenseReport.new(input)

output = expense_report.find_double_key(2020)
info "Report checksum #{output}"