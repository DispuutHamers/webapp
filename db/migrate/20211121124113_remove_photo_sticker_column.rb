class RemovePhotoStickerColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :stickers, :picture
    remove_column :stickers, :image_file_name
    remove_column :stickers, :image_file_size
    remove_column :stickers, :image_content_type
  end
end
