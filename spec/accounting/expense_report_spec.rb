require 'spec_helper'
require 'accounting/expense_report'

RSpec.describe Accounting::ExpenseReport do
  it 'returns double key' do
    report = described_class.new([1721, 979, 366, 299, 675, 1456])
    expect(report.find_double_key(2020)).to eq(514579)
  end

  it 'returns triple key key' do
    report = described_class.new([1721, 979, 366, 299, 675, 1456])
    expect(report.find_triple_key(2020)).to eq(241861950)
  end
end