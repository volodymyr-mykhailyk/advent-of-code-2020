require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/security/password_checker'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

input = input_reader.all_lines.split_with(': ').read
info "Finding invalid passwords in input: #{input.length}"

password_checker = Security::PasswordChecker.new

valid_passwords = input.count { |policy, password| password_checker.valid_for_sled_rental?(policy, password) }
info "Number of valid sled_rental passwords: #{valid_passwords}"

valid_passwords = input.count { |policy, password| password_checker.valid_for_toboggan_authentication?(policy, password) }
info "Number of valid toboggan_authentication passwords: #{valid_passwords}"
