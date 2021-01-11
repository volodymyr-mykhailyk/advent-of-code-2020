require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/travel/airlines/luggage_processing'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

bags_descriptions = input_reader.all_lines.read
info "Processing #{bags_descriptions.length} bag descriptions"

luggage_processing = Travel::Airlines::LuggageProcessing.new(bags_descriptions)
gold_containing_bags_count = luggage_processing.bags_holding_a('shiny gold bag').count
info "Bags that can containing shiny gold bag: #{gold_containing_bags_count}"

bags_inside_gold_bag = luggage_processing.bags_inside_of('shiny gold bag')
info "Number of bags inside shiny gold bag: #{bags_inside_gold_bag}"