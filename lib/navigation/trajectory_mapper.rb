module Navigation
  class TrajectoryMapper
    def initialize(map)
      @map = map
    end

    def calculate_trajectory(delta_x, delta_y)
      x, y, elements = 0, 0, 0
      while y < @map.height
        elements +=1 unless @map.get(x, y).void?
        x += delta_x
        y += delta_y
      end
      elements
    end
  end
end