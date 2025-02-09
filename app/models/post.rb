class Post < ApplicationRecord
  has_one_attached :post_image
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
  validates :post_image, presence: true

  def get_post_image
    (post_image.attached?) ? post_image : 'no_image_471.jpg'
  end
end
