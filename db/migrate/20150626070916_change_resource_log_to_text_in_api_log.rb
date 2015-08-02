class ChangeResourceLogToTextInApiLog < ActiveRecord::Migration
  def change
		reversible do |dir|
			      change_table :api_logs do |t|
							        dir.up   { t.change :resource_call, :text }
											dir.down { t.change :resource_call, :string }
						end
		end
  end
end
