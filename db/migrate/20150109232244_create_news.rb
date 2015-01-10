class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :cat
      t.text :body
      t.string :title
      t.string :image
      t.datetime :date

      t.timestamps
    end
  end
end
