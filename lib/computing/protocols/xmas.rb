require_relative '../structures/list'

module Computing
  module Protocols
    class Xmas
      def initialize(preamble)
        @data_list = Computing::Structures::List.new(preamble.size)
        preamble.each { |data_point| @data_list.push(data_point) }
      end

      def process_next(data_point)
        raise 'invalid sequence' unless @data_list.has_sum?(data_point, 2)
        @data_list.push(data_point)
      end

      class Decipher
        def initialize(data_points, preamble_size)
          @invalid_number = nil
          @data_points = data_points.clone
          @tail = data_points.clone
          @protocol = Computing::Protocols::Xmas.new(@tail.shift(preamble_size))
        end

        def crack_protocol
          @invalid_number = find_invalid_number
          @encryption_weakness = find_encryption_weakness(@invalid_number)
        end

        def invalid_number
          @invalid_number
        end

        def encryption_weakness
          @encryption_weakness
        end

        protected

        def find_invalid_number
          @tail.detect do |number|
            @protocol.process_next(number)
            false
          rescue => _
            true
          end
        end

        def find_encryption_weakness(number)
          lists = @data_points.map.with_index do |_, index|
            sum = 0
            @data_points.drop(index).take_while { |n| (sum += n) <= number }
          end
          sequence = lists.detect { |list| list.size > 1 && list.sum == number }.sort
          sequence.first + sequence.last
        end
      end
    end
  end
end