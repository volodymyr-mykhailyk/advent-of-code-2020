module Energy
  module Conway
    class Cube
      attr_reader :coordinates

      def initialize(coordinates, state)
        @coordinates = coordinates
        @active = parse_state(state)
      end

      def active?
        !!@active
      end

      def position
        coordinates.first
      end

      def prepare_cycle_at(_)
      end

      def all_cubes
        yield self
      end

      def active_cubes
        yield self if active?
      end

      def cubes_around(_coordinates)
        yield self
      end

      def set_state(state, _coordinates)
        @active = parse_state(state)
      end

      def schedule_state(state)
        @future_state = parse_state(state)
      end

      def execute_scheduled_state
        @active = @future_state unless @future_state.nil?
        @future_state = nil
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