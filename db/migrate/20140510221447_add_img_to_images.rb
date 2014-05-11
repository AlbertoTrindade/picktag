class AddImgToImages < ActiveRecord::Migration
  def self.up
    add_attachment :images, :img
  end

  def self.down
    remove_attachment :images, :img
  end
end
