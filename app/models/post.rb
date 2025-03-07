class Post < ApplicationRecord
  has_one_attached :post_image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :post_image, presence: true
  validates :title, presence: true
  validates :body, presence: true
  validates :post_image, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/webp'], size_range: 1..(5.megabytes) }

  def get_post_image(width,height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_471.jpg')
      post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_limit: [width, height]).processed
  end

  # 検索方法:部分一致
  def self.looks(word)
    Post.where("title LIKE?", "%#{word}%")
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
