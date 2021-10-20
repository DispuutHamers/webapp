class DropContentFromPublicPages < ActiveRecord::Migration[6.1]
  def change
    remove_column :public_pages, :content, :text
  end
end
