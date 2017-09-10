class Up < ActiveRecord::Base
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true , length: { minimum: 1 , maximum: 400 }
  belongs_to :user
  mount_uploader :photo, PhotoUploader
end
