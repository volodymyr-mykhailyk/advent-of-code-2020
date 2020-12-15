require 'computing/structures/list'

module Accounting
  class ExpenseReport
    def initialize(numbers)
      @numbers = Computing::Structures::List.new(numbers.count)
      numbers.each { |n| @numbers.push(n) }
    end

    def find_double_key(checksum)
      @numbers.find_sum_combination(checksum, 2).reduce(&:*)
    end

    def find_triple_key(checksum)
      @numbers.find_sum_combination(checksum, 3).reduce(&:*)
    end
  end
end