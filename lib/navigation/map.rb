module Navigation
  class Map
    def initialize(map_lines, elements)
      @map = []
      map_lines.each.with_index do |line, y|
        @map[y] ||= []
        line.split('').each.with_index do |point, x|
          @map[y][x] = elements[point]
        end
      end
    end

    def width
      @map[0].length
    end

    def height
      @map.length
    end

    def get(x, y)
      raise 'out of bounds' unless inbound?(x, y)
      @map[y][x]
    end

    def inbound?(x, y)
      return false if x < 0 || x > width
      return false if y < 0 || y > height
      true
    end

    def map_collection
      @map
    end
  end
end