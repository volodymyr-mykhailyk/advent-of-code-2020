module Accounting
  class ExpenseReport
    def initialize(numbers)
      @numbers = numbers
    end

    def find_double_key(checksum)
      combination = find_combinations(checksum).compact.first
      combination[0] * combination[1]
    end

    protected

    def find_combinations(checksum)
      @numbers.map do |number1|
        next unless (number2 = @numbers.detect { |n2| n2 + number1 == checksum })
        [number1, number2]
      end
    end
  end
end