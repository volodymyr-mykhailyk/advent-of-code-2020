module Energy
  module Conway
    class Cycle
      LIFE_CUBE_COUNT = [2, 3]
      ACTIVATION_CUBE_COUNT = [3]

      def initialize(grid)
        @grid = grid
        @cycle = 0
      end

      def update_cube_state(cube, active_neighbors_cubes)
        if cube.active?
          cube.schedule_state(LIFE_CUBE_COUNT.include?(active_neighbors_cubes))
        else
          cube.schedule_state(ACTIVATION_CUBE_COUNT.include?(active_neighbors_cubes))
        end
      end

      def advance
        @cycle += 1
        @grid.prepare_cycle
        @grid.all_cubes.each do |cube|
          active_neighbors_cubes = @grid.cubes_around(cube).select(&:active?).count
          update_cube_state(cube, active_neighbors_cubes)
        end
        @grid.finish_cycle
      end
    end
  end
end