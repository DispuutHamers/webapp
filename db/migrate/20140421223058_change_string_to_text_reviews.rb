class ChangeStringToTextReviews < ActiveRecord::Migration
  def up
    change_column :reviews, :description, :text
end
def down
    # This might cause trouble if you have strings longer
    # than 255 characters.
    change_column :reviews, :description, :string
end
end
