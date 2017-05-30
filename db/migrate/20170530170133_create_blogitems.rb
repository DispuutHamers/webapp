class CreateBlogitems < ActiveRecord::Migration[5.0]
  def change
    create_table :blogitems do |t|
      t.string :title
      t.text :body
      t.integer :user_id

      t.timestamps
    end
  end
end
