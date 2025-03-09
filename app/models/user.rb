class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :profile_image

  has_many :posts,              dependent: :destroy
  has_many :post_comments,      dependent: :destroy
  has_many :group_users,        dependent: :destroy
  has_many   :permits,          dependent: :destroy
  has_many   :groups,           through: :group_users
  has_many :group_chats,        dependent: :destroy
  has_many :favorites,          dependent: :destroy

  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_471.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end

    if self.guest_user?
      file_path = Rails.root.join('app/assets/images/guestuser.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end

    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end

  # 検索方法:部分一致
  def self.looks(word)
    User.where("name LIKE?", "%#{word}%")
  end


  
end
