class Post < ApplicationRecord
  has_one_attached :post_image
  belongs_to :user

  def get_post_image
    (post_image.attached?) ? post_image : 'no_image_471.jpg'
  end
end
