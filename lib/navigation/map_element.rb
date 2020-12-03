module Navigation
  class MapElement
    attr_reader :symbol

    def initialize(symbol)
      @symbol = symbol
    end

    def ==(symbol)
      @symbol == symbol
    end

    def void?
      @symbol == '.'.freeze
    end
  end
end