class UserAddress < ApplicationRecord
  has_one :user_info, dependent: :nullify
end