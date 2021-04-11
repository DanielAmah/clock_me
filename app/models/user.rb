class User < ApplicationRecord
  has_secure_password
  has_one :user_role
  has_one :role, through: :user_role
  has_one :user_profession
  has_one :profession, through: :user_profession

  validates_presence_of :username, :email, :password_digest
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'requires a valid email format!' } 
  validates :username, uniqueness: true, length: { minimum: 5, message: "is too short!" }

  validates :password,
            length: { minimum: 6, message: "is too short!" },
            if: -> { new_record? || !password.nil? }
end
