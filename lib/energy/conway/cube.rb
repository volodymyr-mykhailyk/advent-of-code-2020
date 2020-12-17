module Energy
  module Conway
    class Cube
      def initialize(x, y, z, state)
        @x, @y, @z = [x, y, z]
        @active = initial_state(state)
      end

      def active?
        !!@active
      end

      def inactive?
        !@active
      end

      def initial_state(state)
        return state.active? if state.is_a?(self.class)
        return state == '#' if state.is_a?(String)
        !!state
      end

      def change_state_on(grid)
        neighbors = grid.get_neighbors_for(cube)
      end

      def to_s
        active? ? '#' : '.'
      end
    end
  end
end