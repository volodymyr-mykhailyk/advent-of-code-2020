require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/computing/protocols/security_doors'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

card_key, door_key = input_reader.all_lines.to_integer.read
subject_number = 7

info "Deciphering encryption for #{card_key}:#{door_key} keys"

decipher = Computing::Protocols::SecurityDoors::Decipher.new

encryption_keys = decipher.find_encryption_keys(subject_number, card_key, door_key)
info "Common encryption keys: #{encryption_keys}"
