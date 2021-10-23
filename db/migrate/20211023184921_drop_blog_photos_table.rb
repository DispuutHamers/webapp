class DropBlogPhotosTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :blogphotos
  end
end
