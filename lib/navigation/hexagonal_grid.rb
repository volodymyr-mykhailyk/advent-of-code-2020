module Navigation
  class HexagonalGrid
    def initialize(initializer)
      @grid = Hash.new { |hash, key| hash[key] = initializer.call(*key) }
    end

    def node_at(coordinates)
      @grid[coordinates]
    end

    def update_at(coordinates, value)
      @grid[coordinates] = value
    end

    def nodes
      @grid.values
    end

    def coordinates
      @grid.keys
    end

    class Navigator
      MOVES = {
        'e' => -> (x, y) { [x + 2, y] },
        'se' => -> (x, y) { [x + 1, y + 1] },
        'sw' => -> (x, y) { [x - 1, y + 1] },
        'w' => -> (x, y) { [x - 2, y] },
        'nw' => -> (x, y) { [x - 1, y - 1] },
        'ne' => -> (x, y) { [x + 1, y - 1] },
      }

      attr_reader :grid, :start

      def initialize(grid, start = [0, 0])
        @grid = grid
        @start = start
      end

      def coordinates_via(path)
        coordinates = start
        while (direction = next_direction(path)) do
          path = path.slice(direction.length..-1)
          coordinates = MOVES[direction].call(*coordinates)
        end
        coordinates
      end

      def adjacent_coordinates(coordinates)
        MOVES.values.map { |lambda| lambda.call(*coordinates) }
      end

      protected

      def next_direction(path)
        return nil unless path && path.length > 0
        MOVES.keys.detect { |direction| path.start_with?(direction) }
      end
    end
  end
end