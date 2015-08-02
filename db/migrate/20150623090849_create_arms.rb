class CreateArms < ActiveRecord::Migration
  def change
    create_table :arms do |t|
      t.string :lat
      t.string :lon
      t.integer :user_id

      t.timestamps
    end
  end
end
