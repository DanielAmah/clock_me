class Role < ApplicationRecord
  has_one :user_role
  has_one :user, through: :user_role

  ALL_ROLES = %w[staff admin].freeze

  enum status: ALL_ROLES.zip(ALL_ROLES).to_h

end
