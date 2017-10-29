class Like < ActiveRecord::Base
  validates :user_id, {presence: true}
  validates :up_id, {presence: true}
end
