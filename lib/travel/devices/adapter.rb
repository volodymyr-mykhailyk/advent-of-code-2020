module Travel
  module Devices
    class Adapter
      def initialize(joltage)
        @joltage = joltage
        @input_range = (joltage-3..joltage-1)
      end

      def plugs_into?(adapter)
        @input_range.include?(adapter.joltage)
      end

      def joltage_diff(adapter)
        return nil unless adapter
        (adapter.joltage - @joltage)
      end

      def device_output
        @joltage + 3
      end

      def joltage
        @joltage
      end
    end
  end
end