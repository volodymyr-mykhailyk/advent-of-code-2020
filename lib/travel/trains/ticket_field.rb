module Travel
  module Trains
    class TicketField
      def initialize(name, conditions)
        @name = name
        @conditions = conditions.split(' or ').map do |condition|
          range = condition.split('-').map(&:to_i)
          (range.first..range.last)
        end
        @position = nil
      end

      def name
        @name
      end

      def is?(name)
        @name.include?(name)
      end

      def match?(value)
        @conditions.any? { |condition| condition.cover?(value) }
      end

      def set_position(position)
        @position = position
      end

      def position
        @position
      end
    end
  end
end