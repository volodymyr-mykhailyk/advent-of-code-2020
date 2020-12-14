require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/computing/docking/computer'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

commands = input_reader.all_lines.read
info "Processing #{commands.length} commands"

docking_computer = Computing::Docking::Computer.new

commands.each { |command| docking_computer.init_command(command) }
info "Memory value: #{docking_computer.memory.map(&:to_i).sum}"
