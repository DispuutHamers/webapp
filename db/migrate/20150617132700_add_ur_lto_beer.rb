class AddUrLtoBeer < ActiveRecord::Migration[5.0]
def change
		add_column :beers, :URL, :string
  end
end
