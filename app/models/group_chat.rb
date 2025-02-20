class GroupChat < ApplicationRecord
  belongs_to :user
  belongs_to :group

  has_one_attached :chat_image

  validates :comment, presence: true

  def get_chat_image(width,height)
    unless chat_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_471.png')
      chat_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    chat_image.variant(resize_to_limit: [width, height]).processed
  end
end
