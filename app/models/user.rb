class User < ApplicationRecord
  has_secure_password
  has_one :user_role
  has_one :role, through: :user_role
  has_one :user_profession
  has_one :profession, through: :user_profession
end
