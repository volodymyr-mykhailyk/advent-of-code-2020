require_relative 'bitmask'

module Computing
  module Docking
    class Computer
      def initialize
        @memory = []
        @bitmask = init_bitmask('mask','X')
      end

      def init_command(command)
        instruction, value = command.split(' = ')
        execute_instruction(instruction, value)
      end

      def memory
        @memory.dup
      end

      def init_bitmask(_instruction, value)
        @bitmask = Bitmask.new(value)
      end

      def save_to_memory(instruction, value)
        memory_address = instruction.gsub(/.*\[(\d+).*/, '\1').to_i
        puts memory_address
        @memory[memory_address] = @bitmask.apply_to(value.to_i)
      end

      def execute_instruction(instruction, value)
        return init_bitmask(instruction, value) if instruction == 'mask'
        return save_to_memory(instruction, value) if instruction.include?('mem[')

        raise 'unknown instruction'
      end
    end
  end
end