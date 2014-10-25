class CreatePublicPages < ActiveRecord::Migration
  def change
    create_table :public_pages do |t|
      t.text :content
      t.string :title
      t.boolean :public

      t.timestamps
    end
  end
end
