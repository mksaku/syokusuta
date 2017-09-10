class CreateUps < ActiveRecord::Migration
  def change
    create_table :ups do |t|

      t.string :photo
      t.text :content
      t.timestamps null: false
    end
  end
end
