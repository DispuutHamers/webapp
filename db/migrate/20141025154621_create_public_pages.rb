class CreatePublicPages < ActiveRecord::Migration[5.0]
def change
    create_table :public_pages do |t|
      t.text :content
      t.string :title
      t.boolean :public

      t.timestamps
    end
  end
end
