class UserInfo < ApplicationRecord
  belongs_to :user
  belongs_to :user_address, optional: true

  enum gender: [ :male, :female, :other ]

  validates :user_id, uniqueness: true

  has_one_attached :user_avatar, dependent: :destroy
end
