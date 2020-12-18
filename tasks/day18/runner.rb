require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/science/math/expression'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

expression_strings = input_reader.all_lines.read
expressions = expression_strings.map { |exp| Science::Math::Expression.new(exp) }

info "Calculating #{expressions.count} expressions"

result_sum = expressions.sum(&:result)
info "Expressions results sum #{result_sum}"