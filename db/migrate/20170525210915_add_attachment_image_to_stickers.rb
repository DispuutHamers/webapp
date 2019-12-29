class AddAttachmentImageToStickers < ActiveRecord::Migration[5.0]
def self.up
    change_table :stickers do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :stickers, :image
  end
end
