class CreatePushes < ActiveRecord::Migration
  def change
    create_table :pushes do |t|
      t.integer :user_id
      t.text :data

      t.timestamps
    end
  end
end
