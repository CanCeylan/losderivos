class AddNewCoulumnsToSessionLogs < ActiveRecord::Migration
  def change
  	add_column :session_logs, :pointer, :datetime
  	add_column :session_logs, :isClosed, :boolean
  	change_column_default(:session_logs, :duration, 0) 
  end
end
