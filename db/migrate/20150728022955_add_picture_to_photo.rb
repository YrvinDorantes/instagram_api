class AddPictureToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :picture, :String
  end
end
