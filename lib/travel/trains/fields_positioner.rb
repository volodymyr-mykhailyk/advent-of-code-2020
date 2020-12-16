module Travel
  module Trains
    class FieldsPositioner
      def initialize(fields)
        @fields = fields
      end

      def find_correct_positions(tickets, positions)
        @fields.each do |field|
          tickets.each do |ticket|
            invalid_positions = ticket.values.map.with_index { |value, index| index unless field.match?(value) }.compact
            positions[field].subtract(invalid_positions)
          end
        end
      end

      def eliminate_duplicates(positions)
        while positions.any? { |_field, set| set.count > 1 } do
          obvious_positions = positions.select { |_field, set| set.count == 1 }
          multi_positions = positions.select { |_field, set| set.count > 1 }
          multi_positions.each { |_field, multi_set| obvious_positions.each { |_field, set| multi_set.subtract(set) } }
        end
      end

      def update_fields(positions)
        positions.each { |field, position| field.set_position(position.first) }
      end

      def guess_positions(tickets)
        positions = Hash[@fields.map { |field| [field, Set.new((0..@fields.count-1).to_a)] }]
        find_correct_positions(tickets, positions)
        eliminate_duplicates(positions)
        update_fields(positions)
      end
    end
  end
end