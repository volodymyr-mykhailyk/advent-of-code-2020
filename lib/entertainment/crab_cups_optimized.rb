module Entertainment
  class CrabCupsOptimized
    attr_reader :cups, :current

    def initialize(cups)
      @move = 1
      @cups = cups.clone
      @index = Hash[cups.map.with_index { |c, i| [c, i] }]
      @current = @cups.first
      @max = @cups.max
    end

    def play_until(move)
      puts "start"
      while @move <= move
        # puts "-- move #{@move} --"
        # puts "cups: #{@cups.index(@current)}:#{@current}#{@cups.inspect}"
        puts "Playing turn #{@move}" if (@move % 100) == 0
        play_turn
      end
    end

    def remove_position(cup)
      position = @index[cup]
      @cups_count -= 1
      @index[cup] = nil
      @index.each_pair { |k, v| @index[k] = index(v - 1) if v && v > position }
    end

    def add_position(cup, position)
      @cups_count += 1
      @index.each_pair { |k, v| @index[k] = v + 1 if v && v >= position }
      @index[cup] = position
    end

    def get_position(cup)
      @index[cup]
    end

    def pick_up_cups
      3.times.map do
        position = index(get_position(@current) + 1)
        cup = @cups.delete_at(position)
        remove_position(cup)
        cup
      end
    end

    def find_destination(destination)
      # puts "search destination: #{destination}:#{@cups.inspect}"
      until get_position(destination) do
        destination = value(destination - 1)
        # puts "search destination: #{destination}:#{@cups.inspect}"
      end
      # puts "destination index #{index(@cups.index(destination) + 1)}"
      get_position(destination) + 1
    end

    def index(index)
      index < 0 ? index(index + cups_count) : index % cups_count
    end

    def value(value)
      value < 0 ? value + @max + 1 : value % @max
    end

    def reinsert_cups(destination, draft)
      draft.each.with_index do |cup, index|
        add_position(cup, destination + index)
      end
      @cups.insert(destination, *draft)
    end

    def play_turn
      @move += 1
      draft = pick_up_cups
      # puts "pick up: #{draft.inspect}"
      destination = find_destination(value(@current - 1))
      # puts "destination: #{destination}:#{@cups.inspect}"
      reinsert_cups(destination, draft)
      @current = @cups[index(get_position(@current) + 1)]
    end

    def cup_labels
      @cups.rotate(@cups.index(1)).last(@cups.size - 1).join('')
    end

    private

    def cups_count
      @cups_count ||= @cups.count
    end
  end
end