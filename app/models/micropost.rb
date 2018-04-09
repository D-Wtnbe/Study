class Micropost < ApplicationRecord
   belongs_to :user
     default_scope -> { order(created_at: :desc) }
   validates :user_id, presence: true
   validates :content, presence: true, length: { maximum: 280 }
   has_many :likes, dependent: :destroy

   # いいね
   def like_user(user_id)
     likes.find_by(user_id: user_id)
   end
end
