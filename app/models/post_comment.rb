class PostComment < ApplicationRecord
  has_one_attached :comment_image
end
