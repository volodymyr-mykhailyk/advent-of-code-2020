module Entertainment
  class HandheldGameConsole
    attr_reader :instructions, :accumulator, :cycle, :pointer

    def initialize(instructions)
      @instructions = instructions
      @execution_stack = Set.new
      @accumulator = 0
      @cycle = 0
      @pointer = 0
    end

    def run
      loop do
        raise 'program is too big' if @cycle > 100_000
        execute_instruction
      end
    end

    def execute_instruction
      raise 'infinite loop' if @execution_stack.include?(pointer)

      change, jump = parse_instruction(*instructions[pointer])
      @execution_stack.add(pointer)
      @accumulator += change
      @pointer += jump
      @cycle += 1
    end

    def parse_instruction(instruction, value)
      return value.to_i, 1 if instruction == 'acc'
      return 0, value.to_i if instruction == 'jmp'
      return 0, 1 if instruction == 'nop'

      raise 'invalid instruction'
    end
  end
end