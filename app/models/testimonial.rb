class Testimonial < ApplicationRecord
  has_one_attached :author_avatar, dependent: :destroy
end
