class AddInvitationCodeToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :invitation_code, :string
  end
end
