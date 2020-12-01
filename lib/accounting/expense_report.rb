module Accounting
  class ExpenseReport
    def initialize(numbers)
      @numbers = numbers
    end

    def find_double_key(checksum)
      combination = find_combinations(2, checksum)
      combination.reduce(&:*)
    end

    def find_triple_key(checksum)
      combination = find_combinations(3, checksum)
      combination.reduce(&:*)
    end

    protected

    def find_combinations(count, checksum)
      @numbers.permutation(count).detect { |numbers| numbers.sum == checksum }
    end
  end
end