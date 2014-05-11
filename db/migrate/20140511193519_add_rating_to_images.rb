class AddRatingToImages < ActiveRecord::Migration
  def change
    add_column :images, :rating, :float
  end
end
