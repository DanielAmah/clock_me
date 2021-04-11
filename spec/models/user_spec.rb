require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_profession) { create :user_profession }
  
  it "is not valid with valid attributes" do
    expect(User.new).to_not be_valid
  end

  subject {
    described_class.new(
                        username: "test1",
                        email: "test@example.com",
                        password: "123456",
                        password_confirmation: "123456"
                        )
  }
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is invalid with invalid email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is invalid with invalid email" do
    subject.email = 'test&dd'
    expect(subject).to_not be_valid
  end

  describe "Associations" do
    it { should have_one(:role) }
    it { should have_one(:user_role) }
    it { should have_one(:profession) }
    it { should have_one(:user_profession) }
  end
end
