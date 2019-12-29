class UpdateDescriptionOfEvent < ActiveRecord::Migration[5.0]
def up
		change_table :events do |t|
		  t.change :beschrijving, :text
		end
	end

	def down
		change_table :events do |t|
			t.change :beschrijving, :string
		end
	end
end
