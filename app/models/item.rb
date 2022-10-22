class Item < ApplicationRecord
  belongs_to :category

  has_one_attached :item_image, dependent: :destroy
end
