require_relative 'cube'

module Energy
  module Conway
    class Grid
      def initialize(dimensions)
        @size = dimensions * 2
        @shift = dimensions
        @grid = []
        range = (0..@size)
        range.each do |z|
          @grid[z] = []
          range.each do |y|
            @grid[z][y] = []
            range.each do |x|
              @grid[z][y][x] = init_cube('.', x, y, z)
            end
          end
        end
      end

      def set_active(x, y, z)
        cube_at(x, y, z).set_active
      end

      def set_inactive(x, y, z)
        cube_at(x, y, z).set_inactive
      end

      def initialize_layer(layer, z = 0)
        x_shift = @shift - layer.size / 2
        y_shift = @shift - layer.first.size / 2
        layer.each.with_index do |line, y|
          line.each.with_index do |state, x|
            init_cube(state, x + x_shift, y + y_shift, z)
          end
        end
      end

      def to_s
        layers = active_layers.map do |layer|
          z = layer.first.first.z
          layer_string = layer.map do |line|
            line.map { |cube| cube }.join('')
          end.join("\n")
          "z=#{z}\n#{layer_string}\n"
        end
        layers.any? ? layers.join("\n") : "<Empty Conway Grid>"
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

      def activity_layers
        @grid.select.with_index do |layer, z|
          layer_active?(layer) || neighbors_layers(z).any? { |neighbor| layer_active?(neighbor) }
        end
      end

      def active_cubes_around(cube)
        neighbor_cubes_around(cube).select(&:active?)
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

      def active_cubes
        active_layers.map { |layer| layer.map { |line| line.select(&:active?) } }.flatten.compact
      end

      protected

      def init_cube(state, x, y, z)
        @grid[z][y][x] = Energy::Conway::Cube.new(x, y, z, state)
      end
    end
  end
end