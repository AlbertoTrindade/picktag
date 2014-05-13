class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.boolean :relevant
      t.integer :user_id
      t.integer :image_id

      t.timestamps
    end
  end
end
