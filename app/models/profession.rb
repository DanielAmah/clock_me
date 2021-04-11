class Profession < ApplicationRecord
  has_one :user_profession
  has_one :user, through: :user_profession
  validates :name, uniqueness: true, length: { minimum: 3, message: "is too short!" }
end
