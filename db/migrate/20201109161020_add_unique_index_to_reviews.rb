class AddUniqueIndexToReviews < ActiveRecord::Migration[6.0]
  def change
    add_index :reviews, [:user_id, :beer_id], unique: true
  end
end
