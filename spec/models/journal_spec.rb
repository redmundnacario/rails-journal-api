require 'rails_helper'

RSpec.describe Journal, type: :model do
  it { expect(described_class.new).to validate_presence_of :title }
  it { expect(described_class.new).to validate_presence_of :description }
  it { expect(described_class.new).to validate_length_of :description }

  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
  end
end