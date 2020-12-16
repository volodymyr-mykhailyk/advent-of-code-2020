module Travel
  module Trains
    class Ticket
      def initialize(fields, values)
        @fields = fields
        @values = values
      end

      def validity_checksum
        @values.select { |value| @fields.none? { |field| field.match?(value) } }.sum
      end

      def valid?
        @values.all? { |value| @fields.any? { |field| field.match?(value) } }
      end

      def fields_by_name(name)
        required_fields = @fields.select { |field| field.is?(name) }
        required_fields.map { |field| @values[field.position] }
      end

      def values
        @values
      end
    end
  end
end