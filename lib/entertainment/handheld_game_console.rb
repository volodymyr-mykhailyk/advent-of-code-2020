module Entertainment
  class HandheldGameConsole
    attr_reader :instructions, :accumulator, :cycle, :pointer

    def initialize(instructions)
      @instructions = instructions.clone
      reset
    end

    def reset
      @execution_stack = Set.new
      @accumulator = 0
      @cycle = 0
      @pointer = 0
    end

    def run(debug = false)
      while pointer < instructions.length do
        execute_instruction
      end
      true
    rescue => e
      puts "Program error #{e.inspect}" if debug
      false
    end

    def safe_mode
      return self.class.new(instructions) if run
      danger_instructions = find_instructions_by(%w[nop jmp])
      broken_instruction = danger_instructions.detect do |position|
        new_instructions = flip_instruction(instructions, position)
        self.class.new(new_instructions).run
      end
      self.class.new(flip_instruction(instructions, broken_instruction))
    end

    def execute_instruction
      raise 'infinite loop' if @execution_stack.include?(pointer)
      raise 'program is too big' if @cycle > 100_000

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

    def self_copy(instructions)
      self.class.new(instructions)
    end

    def flip_instruction(instructions, position)
      new_instructions = instructions.clone
      instruction, value = new_instructions[position]
      changed = instruction == 'jmp' ? 'nop' : 'jmp'
      new_instructions[position] = [changed, value]
      new_instructions
    end

    def find_instructions_by(keys)
      instructions.map.with_index do |instruction, index|
        keys.include?(instruction.first) ? index : nil
      end.compact
    end
  end
end