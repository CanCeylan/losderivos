class AddLocationsToSessionLogs < ActiveRecord::Migration
  def change
    add_reference :session_logs, :location, index: true
    add_foreign_key :session_logs, :locations
  end
end
