module Travel
  module Train
    class TicketField
      def initialize(name, conditions)
        @name = name
        @conditions = conditions.split(' or ').map do |condition|
          range = condition.split('-').map(&:to_i)
          (range.first..range.last)
        end
      end

      def match?(value)
        @conditions.any? { |condition| condition.cover?(value) }
      end
    end
  end
end