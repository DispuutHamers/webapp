class DefaultSignupStatus < ActiveRecord::Migration[6.1]
  def change
    change_column :signups, :status, :boolean, default: true
  end
end
