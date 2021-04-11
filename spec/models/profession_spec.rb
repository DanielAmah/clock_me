require 'rails_helper'

RSpec.describe Profession, type: :model do  
  it "is not valid with valid attributes" do
    expect(Profession.new).to_not be_valid
  end

  subject {
    described_class.new(
                        name: "Lorem ipsum")
  }
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  describe "Associations" do
    it { should have_one(:user_profession) }
    it { should have_one(:user) }
  end
end
