class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :beer_id
      t.integer :user_id
      t.string :description
      t.integer :rating

      t.timestamps
    end
  end
end
