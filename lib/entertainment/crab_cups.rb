module Entertainment
  class CrabCups
    attr_reader :cups, :current

    def initialize(cups)
      @move = 1
      @cups = cups.clone
      @current = @cups.first
      @max = @cups.max
    end

    def play_until(move)
      puts "Playing turn #{@move}" if (@move % 1000) == 0
      while @move <= move
        # puts "-- move #{@move} --"
        # puts "cups: #{@cups.index(@current)}:#{@current}#{@cups.inspect}"
        play_turn
      end
    end

    def pick_up_cups
      3.times.map do
        position = index(@cups.index(@current) + 1)
        @cups.delete_at(position)
      end
    end

    def find_destination(destination)
      # puts "search destination: #{destination}:#{@cups.inspect}"
      until @cups.include?(destination) do
        destination = value(destination - 1)
        # puts "search destination: #{destination}:#{@cups.inspect}"
      end
      # puts "destination index #{index(@cups.index(destination) + 1)}"
      @cups.index(destination) + 1
    end

    def index(index)
      index < 0 ? index(index + @cups.count) : index % @cups.count
    end

    def value(value)
      value < 0 ? value + @max + 1 : value % @max
    end

    def reinsert_cups(destination, draft)
      @cups.insert(destination, *draft)
    end

    def play_turn
      @move += 1
      draft = pick_up_cups
      # puts "pick up: #{draft.inspect}"
      destination = find_destination(value(@current - 1))
      # puts "destination: #{destination}:#{@cups.inspect}"
      reinsert_cups(destination, draft)
      @current = @cups[index(@cups.index(@current) + 1)]
    end

    def cup_labels
      @cups.rotate(@cups.index(1)).last(@cups.size - 1).join('')
    end
  end
end