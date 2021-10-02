class RemoveReviewDescriptionColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :description
  end
end
