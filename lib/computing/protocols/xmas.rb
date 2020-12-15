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
    end
  end
end