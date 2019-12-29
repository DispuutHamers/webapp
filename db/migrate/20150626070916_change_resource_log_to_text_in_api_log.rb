class ChangeResourceLogToTextInApiLog < ActiveRecord::Migration[5.0]
def change
		reversible do |dir|
			      change_table :api_logs do |t|
							        dir.up   { t.change :resource_call, :text }
											dir.down { t.change :resource_call, :string }
						end
		end
  end
end
