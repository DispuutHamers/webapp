class AddAttachmentImageToBlogphotos < ActiveRecord::Migration[5.0]
def self.up
    change_table :blogphotos do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :blogphotos, :image
  end
end
