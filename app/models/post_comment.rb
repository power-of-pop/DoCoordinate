class PostComment < ApplicationRecord
  has_one_attached :comment_image

  belongs_to :user
  belongs_to :post

  validates :comment, presence: true
  validates :comment_image, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/webp'], size_range: 1..(5.megabytes) }
end
