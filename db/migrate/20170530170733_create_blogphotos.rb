class CreateBlogphotos < ActiveRecord::Migration[5.0]
  def change
    create_table :blogphotos do |t|
      t.integer :blogitem_id
      t.string :description

      t.timestamps
    end
  end
end
