class AddAttachmentImageToStickers < ActiveRecord::Migration
  def self.up
    change_table :stickers do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :stickers, :image
  end
end
