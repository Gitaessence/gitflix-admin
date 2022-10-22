class UserType < ApplicationRecord
  enum user_type: [ :super_admin, :admin, :user ]
  has_many :admin_users
  # has_many :users
end