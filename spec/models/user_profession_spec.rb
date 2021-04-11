require 'rails_helper'

RSpec.describe UserProfession, type: :model do
  let(:profession) { create :profession }
  let(:user) { create :user }

  
  it "is not valid with valid attributes" do
    expect(UserProfession.new).to_not be_valid
  end

  subject {
    described_class.new(
                        user_id: user.id,
                        profession_id: profession.id
                        )
  }
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  describe "Associations" do
    it { should have_many(:events) }
    it { should belong_to(:user) }
  end
end
