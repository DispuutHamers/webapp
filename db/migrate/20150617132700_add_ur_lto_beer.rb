class AddUrLtoBeer < ActiveRecord::Migration
  def change
		add_column :beers, :URL, :string
  end
end
