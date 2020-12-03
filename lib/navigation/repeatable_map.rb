require 'delegate'

module Navigation
  class RepeatableMap < SimpleDelegator
    def get(x, y)
      return get(x - width, y) if x >= width
      super
    end
  end
end