module Computing
  module Docking
    class Bitmask
      def initialize(bitmap)
        @bits_map = bitmap.gsub('X', '0').to_i(2)
        @voids_map = bitmap.gsub('X', '1').to_i(2)
      end

      def apply_to(number)
        (number | @bits_map) & @voids_map
      end
    end
  end
end