class ChangeResourceToTextInApiLog < ActiveRecord::Migration[5.0]
class ChangeDateFormatInMyTable < ActiveRecord::Migration[5.0]
def up
				    change_column :api_logs, :resource_log, :text
						  end

			  def down
				    change_column :api_logs, :resource_log, :string
							  end
  end
end
