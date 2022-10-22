class Category < ApplicationRecord
  belongs_to :admin_user
  belongs_to :course_level
  has_many :items, dependent: :destroy
  has_many :enrollements, dependent: :destroy

  has_one_attached :author_avatar, dependent: :destroy
  has_one_attached :category_image, dependent: :destroy
end