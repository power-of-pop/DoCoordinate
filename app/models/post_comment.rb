class PostComment < ApplicationRecord
  has_one_attached :comment_image

  belongs_to :user
  belongs_to :post

  validates :comment, presence: true
end
