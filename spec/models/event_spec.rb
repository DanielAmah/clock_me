require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user_profession) { create :user_profession }
  
  it "is not valid with valid attributes" do
    expect(Event.new).to_not be_valid
  end

  subject {
    described_class.new(
                        description: "Lorem ipsum",
                        clock_in: DateTime.now,
                        user_profession_id: user_profession.id)
  }
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a user profession" do
    subject.user_profession_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid if clock in is greater than clock out time" do
    subject.clock_in = "2021-04-21T10:45:22"
    subject.clock_out = "2021-04-21T08:45:22"
    expect(subject).to_not be_valid
  end

  it "is not valid if the diff of clock in and clock out is greater than 24" do
    subject.clock_in = "2021-04-21T10:45:22"
    subject.clock_out = "2021-06-21T08:45:22"
    expect(subject).to_not be_valid
  end

  describe "Associations" do
    it { should belong_to(:user_profession)}
  end

end
