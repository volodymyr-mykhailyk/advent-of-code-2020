require 'ripper'

module Science
  module Math
    class Expression
      attr_reader :operator

      def initialize(expression)
        tokens = expression.is_a?(Array) ? expression : Tokenizer.new.tokens(expression)
        @operator = parse_tokens(tokens)
      end

      def result
        @operator.result
      end

      def parse_tokens(tokens)
        return tokens.first if tokens.length == 1

        left = parse_element(tokens.shift)
        operator = parse_element(tokens.shift)
        right = parse_element(tokens.shift)
        operator.assign_operands(left, right)

        tokens.unshift(operator)

        parse_tokens(tokens)
      end

      def parse_element(element)
        return element if element.is_a?(Operator)
        return Expression.new(element) if element.is_a?(Array)
        return Sum.new if element == '+'
        return Multiply.new if element == '*'
        return Number.new(element) if element =~ /^\d+/
        raise "unknown element: #{element.inspect}"
      end

      class Operator
      end

      class Sum < Operator
        attr_reader :left, :right

        def assign_operands(left, right)
          @left, @right = [left, right]
        end

        def result
          left.result + right.result
        end
      end

      class Multiply < Operator
        attr_reader :left, :right

        def assign_operands(left, right)
          @left, @right = [left, right]
        end

        def result
          left.result * right.result
        end
      end

      class Number
        def initialize(text)
          @value = text.to_i
        end

        def result
          @value
        end
      end

      class Tokenizer
        def tokens(text)
          tokens = Ripper.tokenize(text).reject { |t| t == ' ' }
          group_expressions(tokens)
        end

        protected

        def group_expressions(tokens)
          return nil if tokens.empty?
          return tokens unless tokens.include?('(')
          start = []
          while tokens[0] != '(' do
            start.push tokens.shift
          end
          group = []
          parentesis = 0
          loop do
            char = tokens.shift
            parentesis += 1 if char == '('
            parentesis -= 1 if char == ')'
            group.push char
            break if parentesis == 0
          end
          group = group[1..-2]
          start.push(group_expressions(group), *group_expressions(tokens)).compact
        end
      end
    end
  end
end