require 'spec_helper'
require 'airlines/tickets_scanner'

describe Airlines::TicketsScanner do
  let(:scanner) { described_class.new }

  describe '#seat_id' do
    it 'returned for use case 1' do
      expect(scanner.seat_id('FBFBBFFRLR')).to eq(357)
    end

    it 'returned for use case 2' do
      expect(scanner.seat_id('BFFFBBFRRR')).to eq(567)
    end

    it 'returned for use case 3' do
      expect(scanner.seat_id('FFFBBBFRRR')).to eq(119)
    end

    it 'returned for use case 4' do
      expect(scanner.seat_id('BBFFBBFRLL')).to eq(820)
    end
  end
end