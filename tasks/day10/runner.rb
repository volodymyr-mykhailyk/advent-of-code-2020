require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/travel/devices/adapter'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

adapters_joltage = input_reader.all_lines.to_integer.read
adapters = adapters_joltage.map { |joltage| Travel::Devices::Adapter.new(joltage) }.sort_by(&:joltage)
outlet = Travel::Devices::Adapter.new(0)
device = Travel::Devices::Adapter.new(adapters.last.device_output)
adapters.unshift(outlet).push(device)

info "Checking #{adapters.length} adapters"
info "Device joltage #{adapters.last.device_output}"

joltage_diff = adapters.map.with_index { |adapter, index| adapter.joltage_diff(adapters[index + 1]) }.compact
joltage_multiplier = joltage_diff.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }.values.reduce(&:*)

info "Joltage Multiplier: #{joltage_multiplier}"

