class AddUserIdToMotion < ActiveRecord::Migration
  def change
    add_column :motions, :user_id, :integer
  end
end
