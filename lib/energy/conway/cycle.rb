module Energy
  module Conway
    class Cycle
      LIFE_CUBE_COUNT = [2, 3]
      ACTIVATION_CUBE_COUNT = [3]

      def initialize(grid)
        @grid = grid
        @cycle = 0
      end

      def activate_cube(cube, active_neighbors_cubes)
        if cube.active?
          if LIFE_CUBE_COUNT.include?(active_neighbors_cubes)
            cube.set_active
          else
            cube.set_inactive
          end
        else
          if ACTIVATION_CUBE_COUNT.include?(active_neighbors_cubes)
            cube.set_active
          else
            cube.set_inactive
          end
        end
      end

      def advance
        puts "****" * 10
        puts @cycle
        @cycle += 1
        cache = @grid.clone
        @grid.activity_layers.each do |layer|
          layer.each do |line|
            line.each do |cube|
              active_neighbors_cubes = cache.active_cubes_around(cube).count
              activate_cube(cube, active_neighbors_cubes)
            end
          end
        end
        puts "****" * 10
        puts @grid
      end
    end
  end
end