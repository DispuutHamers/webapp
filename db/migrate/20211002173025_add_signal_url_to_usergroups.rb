class AddSignalUrlToUsergroups < ActiveRecord::Migration[6.1]
  def change
    add_column :usergroups, :signal_url, :string
  end
end
