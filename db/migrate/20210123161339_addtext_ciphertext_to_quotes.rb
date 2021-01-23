class AddtextCiphertextToQuotes < ActiveRecord::Migration[6.0]
  def change
    add_column :quotes, :text_ciphertext, :text
  end
end
