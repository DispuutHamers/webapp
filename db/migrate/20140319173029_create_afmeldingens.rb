class CreateAfmeldingens < ActiveRecord::Migration
  def change
    create_table :afmeldingens do |t|
      t.string :reden
      t.integer :user_id

      t.timestamps
    end
  end
end
