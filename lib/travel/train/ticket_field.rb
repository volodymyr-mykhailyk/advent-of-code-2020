module Travel
  module Train
    class TicketField
      def initialize(name, conditions)
        @name = name
        @conditions = conditions.split(' or ').map do |condition|
          range = condition.split('-').map(&:to_i)
          (range.first..range.last)
        end
        @invalid_positions = Set.new
        @valid_positions = Set.new
      end

      def is?(name)
        @name.include?(name)
      end

      def match?(value)
        @conditions.any? { |condition| condition.cover?(value) }
      end

      def guess_position(value, index)
        if match?(value)
          @valid_positions.add(index) unless @invalid_positions.include?(index)
        else
          @valid_positions.delete(index)
          @invalid_positions.add(index)
        end
      end

      def position
        @valid_positions
      end

      def multivariant?
        position.count > 1
      end

      def remove_positions(set)
        @valid_positions = @valid_positions - set
      end
    end
  end
end