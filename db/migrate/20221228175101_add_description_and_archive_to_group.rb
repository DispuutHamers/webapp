class AddDescriptionAndArchiveToGroup < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :description, :text, null: true, max_length: 1000
    add_column :groups, :archived, :boolean, default: false
  end
end
