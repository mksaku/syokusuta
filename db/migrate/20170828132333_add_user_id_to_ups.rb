class AddUserIdToUps < ActiveRecord::Migration
  def change
    add_column :ups, :user_id, :integer
  end
end
