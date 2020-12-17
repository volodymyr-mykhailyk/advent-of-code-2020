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
          cube.schedule_state(LIFE_CUBE_COUNT.include?(active_neighbors_cubes))
        else
          cube.schedule_state(ACTIVATION_CUBE_COUNT.include?(active_neighbors_cubes))
        end
      end

      def advance
        puts "****" * 10
        puts @cycle
        @cycle += 1
        @grid.activity_layers.each do |layer|
          layer.each do |line|
            line.each do |cube|
              active_neighbors_cubes = @grid.active_cubes_around(cube).count
              activate_cube(cube, active_neighbors_cubes)
            end
          end
        end
        @grid.activity_layers.each do |layer|
          layer.each do |line|
            line.each do |cube|
              cube.execute_scheduled_state
            end
          end
        end
        puts "****" * 10
        puts @grid
      end
    end
  end
end