class AddUseridToExternalSignups < ActiveRecord::Migration[6.1]
  def change
    add_column :external_signups, :user_id, :integer, null: true
  end
end
