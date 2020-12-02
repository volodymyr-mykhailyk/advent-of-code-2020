require 'spec_helper'
require 'security/password_checker'

RSpec.describe Security::PasswordChecker do
  subject(:checker) { described_class.new }
  it 'checks valid password' do
    expect(checker.valid?('1-3 m', 'mmpth')).to be_truthy
  end

  it 'checks invalid password' do
    expect(checker.valid?('4-5 m', 'mmpth')).to be_falsey
  end
end