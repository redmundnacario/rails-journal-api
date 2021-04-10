require 'rails_helper'

RSpec.describe Task, type: :model do
  it { expect(described_class.new).to validate_presence_of :title }
  it { expect(described_class.new).to validate_presence_of :description }
  it { expect(described_class.new).to validate_presence_of :deadline }
  it { expect(described_class.new).to validate_presence_of :done }
  it { expect(described_class.new).to validate_length_of :description }

  describe 'associations' do
    it { should belong_to(:journal).class_name('Journal') }
  end
end