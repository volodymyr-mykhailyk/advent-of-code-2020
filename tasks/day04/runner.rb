require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/customs/passport_scanner'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

passports = input_reader.all_groups.split_with(/\s/).read
passports = passports.map { |passport| Hash[passport.map { |identifier| identifier.split(':') }] }

info "Processing #{passports.length} passports"

scanner = Customs::PasswordScanner.new

correct_passports = passports.select { |pasport| scanner.has_all_fields?(pasport) }
info "Found #{correct_passports.length} correct passports"

valid_passports = correct_passports.select { |pasport| scanner.has_all_valid_fields?(pasport) }
info "Found #{valid_passports.length} valid passports"
