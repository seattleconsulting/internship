class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true,
                      length: { maximum: 140 }
  validate  :picture_size
  has_many :likes, dependent: :destroy

  # マイクロポストをいいねする
  def like(user)
    likes.create(user: user)
  end
  # マイクロポストのいいねを解除する（ネーミングセンスに対するクレームは受け付けません）
  def unlike(user)
    likes.find_by(user: user).destroy
  end

  private

  # アップロードされた画像のサイズをバリデーションする
  def picture_size
    if picture.size > 1.megabytes
      errors.add(:picture, "should be less than 1MB")
    end
  end
end
