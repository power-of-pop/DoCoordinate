class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # user_idとpost_idのペアが一意である制限
  validates :user_id, uniqueness: {scope: :post_id}
end
