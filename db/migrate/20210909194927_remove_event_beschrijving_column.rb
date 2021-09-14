class RemoveEventBeschrijvingColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :beschrijving
  end
end
