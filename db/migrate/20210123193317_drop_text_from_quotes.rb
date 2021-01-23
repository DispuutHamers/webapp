class DropTextFromQuotes < ActiveRecord::Migration[6.0]
  def up
    remove_column :quotes, :text
  end

  def down
    add_column :quotes, :text, :string
  end
end
