require 'rails_helper'

RSpec.describe UserRole, type: :model do
  let(:role) { create :role }
  let(:user) { create :user }

  
  it "is not valid with valid attributes" do
    expect(UserRole.new).to_not be_valid
  end

  subject {
    described_class.new(
                        user_id: user.id,
                        role_id: role.id
                        )
  }
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  describe "Associations" do
    it { should belong_to(:role) }
    it { should belong_to(:user) }
  end
end
