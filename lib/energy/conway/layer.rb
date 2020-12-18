module Energy
  module Conway
    class Layer
      NAMES = %w[x y z w]

      attr_reader :name, :position, :coordinates, :depth

      def initialize(parent, depth, position)
        @position = position
        @coordinates = ([position] + parent.coordinates).compact
        @name = NAMES[depth]
        @depth = depth
        @layer = Hash.new
      end

      def set_state(state, coordinates)
        coords = coordinates.clone
        pos = coords.pop
        prepare_element(pos).set_state(state, coords)
      end

      def build_element(element_position)
        return Cube.new([element_position] + coordinates, false) if depth == 0
        Layer.new(self, depth - 1, element_position)
      end

      def prepare_cycle_at(coordinates)
        coords = coordinates.clone
        pos = coords.pop
        [pos - 1, pos, pos + 1].map { |x| prepare_element(x) }.each { |element| element.prepare_cycle_at(coords) }
      end

      def active_cubes(&block)
        elements.each { |element| element.active_cubes(&block) }
      end

      def all_cubes(&block)
        elements.each { |element| element.all_cubes(&block) }
      end

      def cubes_around(coordinates, &block)
        coords = coordinates.clone
        pos = coords.pop
        [pos - 1, pos, pos + 1].map { |x| element(x) }.compact.each { |element| element.cubes_around(coords, &block) }
      end

      def active?
        elements.any?(&:active?)
      end

      def to_text(left_padding)
        return sorted_elements.map { |element| element.to_text(left_padding) }.join("\n") if depth == 1
        return "#{' ' * (left_padding + sorted_keys.min)}#{sorted_elements.map(&:to_s).join('')}" if depth == 0
        sorted_keys.map { |key| "#{@name}=#{key}\n#{element(key).to_text(left_padding)}" }.join("\n\n")
      end

      def horizontal_dimensions
        return [sorted_keys.min || 0, sorted_keys.max || 0] if depth == 0
        dimensions = elements.map(&:horizontal_dimensions)
        min = dimensions.map { |dim| dim.first }.min
        max = dimensions.map { |dim| dim.last }.max
        [min || 0, max || 0]
      end

      private

      def elements
        @layer.values
      end

      def sorted_elements
        @layer.keys.sort.map { |key| @layer[key] }
      end

      def sorted_keys
        @layer.keys.sort
      end

      def prepare_element(pos)
        @layer[pos] ||= build_element(pos)
      end

      def element(pos)
        @layer[pos]
      end
    end
  end
end