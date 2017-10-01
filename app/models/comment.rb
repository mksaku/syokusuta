class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :up
  has_many :notifications, dependent: :destroy
end
