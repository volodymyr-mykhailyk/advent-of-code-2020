require_relative 'cube'

module Energy
  module Conway
    class Grid
      def initialize(dimensions)
        @shift = dimensions
        @grid = []
        range = (0..dimensions * 2)
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

      def init_cube(state, x, y, z)
        @grid[z][y][x] = Energy::Conway::Cube.new(x, y, z, state)
      end

      def initialize_layer(layer, z = 0)
        x_shift = @shift - layer.size / 2
        y_shift = @shift - layer.first.size / 2
        layer.each.with_index do |line, x|
          line.each.with_index do |state, y|
            init_cube(state, x + x_shift, y + y_shift, z)
          end
        end
      end

      def to_s
        non_empty_layers = @grid.reject { |layer| layer_empty?(layer) }
        non_empty_layers.map.with_index do |layer, z|
          layer_string = layer.map do |line|
            line.map { |cube| cube }.join('')
          end.join("\n")
          "z=#{z}\n#{layer_string}\n"
        end.join("\n")
      end

      def layer_empty?(layer)
        layer.all? { |line| line.all?(&:inactive?) }
      end

      def clone
        clone = self.class.new(@shift)
        @grid.each.with_index do |layer, z|
          clone.initialize_layer(layer, z)
        end
        clone
      end
    end
  end
end