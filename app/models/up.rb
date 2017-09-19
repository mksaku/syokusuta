class Up < ActiveRecord::Base
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true , length: { minimum: 1 , maximum: 400 }
  belongs_to :user
 # CommentモデルのAssociationを設定
 has_many :comments, dependent: :destroy
  mount_uploader :photo, PhotoUploader
end
