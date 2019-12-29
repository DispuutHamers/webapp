class ChangeDataInPushToText < ActiveRecord::Migration[5.0]
def change
		reversible do |dir|
			change_table :pushes do |t|
				dir.up   { t.change :data, :text }
				dir.down { t.change :data, :string }
			end
		end
	end
end
