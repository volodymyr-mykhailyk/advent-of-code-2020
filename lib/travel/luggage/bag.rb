module Travel
  module Luggage
    class Bag
      attr_reader :info, :contents
      attr_writer :contents

      def initialize(info)
        @info = info
        @contents = {}
      end

      def is?(bag)
        @info == bag
      end

      def holds?(another_bag)
        @contents.keys.any? { |bag| bag.is?(another_bag) || bag.holds?(another_bag) }
      end
    end
  end
end