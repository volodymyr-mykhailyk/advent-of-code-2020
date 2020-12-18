require_relative 'cube'
require_relative 'layer'

module Energy
  module Conway
    class Grid
      attr_reader :dimensions

      def initialize(dimensions)
        raise 'wrong dimensions' unless dimensions > 1
        @dimensions = dimensions
        @layer = Layer.new(self, dimensions - 1, 0)
      end

      def coordinates
        []
      end

      def set_state(state, coordinates)
        @layer.set_state(state, coordinates)
      end

      def set_inactive(x, y, z)
        cube_at(x, y, z).set_inactive
      end

      def initialize_from_plane(plane, coordinates)
        plane.each.with_index do |line, y|
          line.each.with_index do |state, x|
            @layer.set_state(state, coordinates.clone.unshift(x, y))
          end
        end
      end

      def to_s
        @layer.to_text(dimensions - 1)
      end

      def layer_empty?(layer)
        layer.all? { |line| line.all?(&:inactive?) }
      end

      def layer_active?(layer)
        layer.any? { |line| line.any?(&:active?) }
      end

      def active_layers
        @grid.select { |layer| layer_active?(layer) }
      end

      def neighbors_layers(z)
        return [@grid[z + 1]] if z == 0
        return [@grid[z - 1]] if z == @size
        [@grid[z - 1], @grid[z + 1]]
      end

      def prepare_cycle
        active_cubes.each { |cube| @layer.prepare_cycle_at(cube.coordinates) }
      end

      def activity_cubes
        @layer.enum_for(:activity_cubes)
      end

      def all_cubes
        @layer.enum_for(:all_cubes)
      end

      def active_cubes
        @layer.enum_for(:active_cubes)
      end

      def active_cubes_around(cube)
        @layer.enum_for(:active_cubes_around, cube.coordinates).reject { |c| c == cube }
      end

      def neighbor_cubes_around(cube)
        x, y, z = cube.coordinates
        get_cubes([x - 1, x, x + 1], [y - 1, y, y + 1], [z - 1, z, z + 1]).reject { |c| c.at?(cube.coordinates) }
      end

      def get_cubes(xs, ys, zs)
        zs.map do |z|
          ys.map do |y|
            xs.map do |x|
              cube_at(x, y, z)
            rescue
              nil
            end
          end
        end.flatten.compact
      end

      def cube_at(x, y, z)
        raise "out of bounds [#{x}, #{y}, #{z}]" if out_of_bounds?(x) || out_of_bounds?(y) || out_of_bounds?(z)
        @grid[z][y][x]
      end

      def out_of_bounds?(coordinate)
        coordinate < 0 || coordinate > @size
      end


      protected

      def init_cube(state, coordinates)
        @grid[z][y][x] = Energy::Conway::Cube.new([x, y, z], state)
      end
    end
  end
end