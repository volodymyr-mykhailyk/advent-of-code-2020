require_relative 'cube'
require_relative 'layer'

module Energy
  module Conway
    class Grid
      attr_reader :dimensions

      def initialize(dimensions)
        raise 'wrong dimensions' unless dimensions > 1
        @dimensions = dimensions
        @layer = Layer.new(self, dimensions - 1, nil)
      end

      def initialize_from_plane(plane, coordinates)
        plane.each.with_index do |line, y|
          line.each.with_index do |state, x|
            set_state(state, coordinates.clone.unshift(x, y))
          end
        end
      end

      def set_state(state, coordinates)
        @layer.set_state(state, coordinates)
      end

      def prepare_cycle
        active_cubes.each { |cube| @layer.prepare_cycle_at(cube.coordinates) }
      end

      def finish_cycle
        all_cubes.each { |cube| cube.execute_scheduled_state }
      end

      def all_cubes
        @layer.enum_for(:all_cubes)
      end

      def active_cubes
        @layer.enum_for(:active_cubes)
      end

      def cubes_around(cube)
        @layer.enum_for(:cubes_around, cube.coordinates).reject { |c| c == cube }
      end

      def to_s
        left_padding = @layer.horizontal_dimensions.first
        @layer.to_text(-left_padding)
      end

      def coordinates
        []
      end
    end
  end
end