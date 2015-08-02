class ChangeResourceToTextInApiLog < ActiveRecord::Migration
  class ChangeDateFormatInMyTable < ActiveRecord::Migration
		  def up
				    change_column :api_logs, :resource_log, :text
						  end
			
			  def down
				    change_column :api_logs, :resource_log, :string
							  end
  end
end
