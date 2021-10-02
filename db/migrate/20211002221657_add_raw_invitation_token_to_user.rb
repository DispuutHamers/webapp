class AddRawInvitationTokenToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :raw_invitation_token, :string
  end
end
