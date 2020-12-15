require 'delegate'

module Computing
  module Structures
    class List < DelegateClass(Array)
      def initialize(size)
        @size = size
        super(Array.new)
      end

      def push(item)
        shift if size >= @size
        super
      end

      def has_sum?(result, elements = 2)
        !!find_sum_combination(result, elements)
      end

      def find_sum_combination(result, elements = 2)
        combination(elements).detect { |numbers| numbers.sum == result }
      end
    end
  end
end