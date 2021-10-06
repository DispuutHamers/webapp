class RemoveColumnBodyFromBlogitem < ActiveRecord::Migration[6.1]
  def change
    remove_column :blogitems, :body
  end
end
