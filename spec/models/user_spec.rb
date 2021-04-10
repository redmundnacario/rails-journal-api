require 'rails_helper'

RSpec.describe User, type: :model do
  
  context 'basic validations' do
    # it { should validate_presence_of(:name) }
  
    it { expect(described_class.new).to validate_presence_of :username }
    it { expect(described_class.new).to validate_presence_of :email }
    it { expect(described_class.new).to validate_presence_of :password_digest}
    it { should validate_uniqueness_of(:email)}
    it { expect(described_class.new).to validate_length_of :password_digest }
  end
end