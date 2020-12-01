module Utils
  module Printer
    def info(message)
      puts '**' * 40
      puts message
    end
  end
end

include Utils::Printer