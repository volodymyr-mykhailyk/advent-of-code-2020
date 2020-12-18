require_relative '../utils/printer'
require_relative '../utils/input_reader'
require_relative '../../lib/science/math/calculator'

input_reader = Utils::InputReader.new(File.expand_path('input.txt'))

expression_strings = input_reader.all_lines.read
equal_priority_parser = Science::Math::Calculator::EqualPriorityParser.new
sum_king_parser = Science::Math::Calculator::SumKingParser.new

expressions = expression_strings.map { |exp| Science::Math::Calculator.new(exp, equal_priority_parser) }

info "Calculating #{expressions.count} expressions"

result_sum = expressions.sum(&:result)
info "Expressions result for equal priorities operators #{result_sum}"

expressions = expression_strings.map { |exp| Science::Math::Calculator.new(exp, sum_king_parser) }
result_sum = expressions.sum(&:result)
info "Expressions result for sum king priority operators #{result_sum}"
