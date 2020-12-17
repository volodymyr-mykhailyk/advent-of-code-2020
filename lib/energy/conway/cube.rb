module Energy
  module Conway
    class Cube
      attr_reader :x, :y, :z

      def initialize(x, y, z, state)
        @x, @y, @z = [x, y, z]
        @active = parse_state(state)
      end

      def coordinates
        [x, y, z]
      end

      def at?(coordinates)
        x == coordinates[0] && y == coordinates[1] && z == coordinates[2]
      end

      def active?
        !!@active
      end

      def set_state(state)
        @active = parse_state(state)
      end

      def schedule_state(state)
        @future_state = parse_state(state)
      end

      def execute_scheduled_state
        @active = @future_state unless @future_state.nil?
        @future_state = nil
      end

      def inactive?
        !@active
      end

      def to_s
        active? ? '#' : '.'
      end

      protected

      def parse_state(state)
        return state.active? if state.is_a?(self.class)
        return state == '#' if state.is_a?(String)
        !!state
      end
    end
  end
end