module Energy
  module Conway
    class Layer
      def initialize(layer)
        @layer = layer
      end

      def is_empty?
        @layer.any? { |line| line.any?(&:active?) }
      end
    end
  end
end