class AddDescriptionAndArchivedToUserGroup < ActiveRecord::Migration[6.1]
  def change
    add_column :usergroups, :description, :string
    add_column :usergroups, :archived, :boolean, default: false
  end
end
