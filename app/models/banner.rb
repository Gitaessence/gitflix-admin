class Banner < ApplicationRecord
  has_one_attached :banner_image, dependent: :destroy

  enum device_type: [:both, :mobile, :desktop]
end