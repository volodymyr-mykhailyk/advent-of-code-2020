require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/customs/passport_scanner'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

passports = []
current_passport = []
input_reader.all_lines.split_with(' ').read.each do |line|
  if line.empty?
    passports << current_passport.to_h
    current_passport = []
  else
    current_passport.concat(line.map { |pair| pair.split(':') })
  end
end
passports << current_passport.to_h
info "Processing #{passports.length} passports"

scanner = Customs::PasswordScanner.new

correct_passports = passports.select { |pasport| scanner.has_all_fields?(pasport) }
info "Found #{correct_passports.length} correct passports"

valid_passports = correct_passports.select { |pasport| scanner.has_all_valid_fields?(pasport) }
info "Found #{valid_passports.length} valid passports"
