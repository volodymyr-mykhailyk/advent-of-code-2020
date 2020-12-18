module Energy
  module Conway
    class Layer
      NAMES = %w[x y z w]

      attr_reader :name, :position, :coordinates, :depth

      def initialize(parent, depth, position)
        @position = position
        @coordinates = [position] + parent.coordinates
        @name = NAMES[depth]
        @depth = depth
        @layer = Hash.new
      end

      def set_state(state, coordinates)
        coords = coordinates.clone
        pos = coords.shift
        element(pos).set_state(state, coords)
      end

      def build_element(element_position)
        return Cube.new([element_position] + coordinates, false) if depth == 0
        Layer.new(self, depth - 1, element_position)
      end

      def prepare_cycle_at(coordinates)
        coords = coordinates.clone
        pos = coords.shift
        [element(pos - 1), element(pos), element(pos + 1)].each { |element| element.prepare_cycle_at(coords) }
      end

      def activity_cubes(&block)
        activity_elements = elements.select do |element|
          pos = element.position
          element.active? || element_or_nil(pos - 1).active? || element_or_nil(pos + 1).active?
        end
        activity_elements.each { |element| element.activity_cubes(&block) }
      end

      def active_cubes(&block)
        elements.each { |element| element.active_cubes(&block) }
      end

      def all_cubes(&block)
        elements.each { |element| element.all_cubes(&block) }
      end

      def active_cubes_around(coordinates, &block)
        coords = coordinates.clone
        pos = coords.shift
        [element_or_nil(pos - 1), element_or_nil(pos), element_or_nil(pos + 1)].compact.each { |element| element.active_cubes_around(coords, &block) }
      end

      def neighbors_elements(pos)
        [element(pos - 1), element(pos + 1)]
      end

      def active?
        elements.any?(&:active?)
      end

      def to_text(depth)
        return elements.map { |element| element.to_text(depth - 1) }.join("\n") if depth == 1
        return elements.map(&:to_s).join('') if depth == 0
        "#{@name}=#{@position}#{elements.map { |element| element.to_text(depth - 1) }.join("\n\n")}"
      end

      private

      def elements
        @layer.values
      end

      def sorted_elements
        @layer.keys.sort.map { |key| @layer[key] }
      end

      def element(pos)
        @layer[pos] ||= build_element(pos)
      end

      def element_or_nil(pos)
        @layer[pos] ||= build_element(pos)
      end

      def expand_for_activity
        first = sorted_elements.first
        last = sorted_elements.last
        element(first.position - 1) if first.active?
        element(last.position + 1) if last.active?
      end
    end
  end
end