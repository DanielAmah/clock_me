require 'rails_helper'

RSpec.describe Role, type: :model do
  
  it "is not valid with valid attributes" do
    expect(Role.new).to be_valid
  end

  subject {
    described_class.new(
                        status: "admin")
  }
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  describe "Associations" do
    it { should have_one(:user_role) }
    it { should have_one(:user) }
  end
end
