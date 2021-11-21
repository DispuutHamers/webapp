class AddAddressColumnToSticker < ActiveRecord::Migration[6.1]
  def change
    add_column :stickers, :address, :string
  end
end
