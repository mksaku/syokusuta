class Up < ActiveRecord::Base
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true , length: { minimum: 1 , maximum: 400 }
  belongs_to :user
  validates :photo, presence: true
 # CommentモデルのAssociationを設定
 has_many :comments, dependent: :destroy
  mount_uploader :photo, PhotoUploader

  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
end
