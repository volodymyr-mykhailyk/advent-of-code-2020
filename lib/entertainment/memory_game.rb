module Entertainment
  class MemoryGame
    def initialize(sequence)
      @number_last = Hash[sequence.map.with_index { |num, index| [num, index + 1] }]
      @number_previous = {}
      @last_spoken = sequence.last
      @current_turn = sequence.count
    end

    def advance_to(turn)
      (turn - @current_turn).times do
        @current_turn += 1
        if !@number_previous[@last_spoken]
          @last_spoken = 0
        else
          @last_spoken = @number_last[@last_spoken] - @number_previous[@last_spoken]
        end
        @number_previous[@last_spoken] = @number_last[@last_spoken]
        @number_last[@last_spoken] = @current_turn
      end
    end

    def current_number
      @last_spoken
    end
  end
end