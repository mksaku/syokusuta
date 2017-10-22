class AddTitleToUp < ActiveRecord::Migration
  def change
    add_column :ups, :title, :string
  end
end
