module Airlines
  class TicketsScanner
    def seat_id(boarding_pass)
      binary_pass(boarding_pass)
    end

    private

    def binary_pass(boarding_pass)
      text = boarding_pass.gsub('F', '0').gsub('B', '1').gsub('L', '0').gsub('R', '1')
      text.to_i(2)
    end
  end
end