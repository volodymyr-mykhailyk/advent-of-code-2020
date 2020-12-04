module Utils
  class InputReader
    def initialize(path)
      @path = path
      @output = nil
    end

    def all_lines
      @output = file.readlines.map(&:chomp)
      self
    end

    def one_line
      @output = file.readline.chomp
      self
    end

    def split_with(separator)
      @output = convert_output { |element| element.split(separator) }
      self
    end

    # def group_using(separator)
    #   position = 0
    #   chunked = @output.chunk do |e|
    #     position += 1 if e == separator
    #     position
    #   end
    #   puts chunked.to_a.inspect
    #   @output = chunked.map { |_p, group| group }
    #   self
    # end

    def to_integer
      @output = convert_output { |element| element.to_i }
      self
    end

    def read
      @output
    end

    protected

    def convert_output(&block)
      if @output.is_a?(Array)
        @output.map(&block)
      else
        yield @output
      end
    end

    def file
      File.open(@path)
    end
  end
end