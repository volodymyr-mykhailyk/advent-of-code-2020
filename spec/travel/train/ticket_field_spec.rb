require 'spec_helper'
require 'travel/trains/ticket_field'

describe Travel::Trains::TicketField do
  let(:field) {Travel::Trains::TicketField.new('class', '1-3 or 5-7')}

  describe '#matches?' do
    it 'matches boundary value' do
      expect(field).to be_match(3)
    end

    it 'matches middle value' do
      expect(field).to be_match(6)
    end

    it 'not matches between ranges value' do
      expect(field).to_not be_match(4)
    end

    it 'not matches outside ranges value' do
      expect(field).to_not be_match(8)
    end
  end
end