class CreateSessionLogs < ActiveRecord::Migration
  def change
    create_table :session_logs do |t|
      t.string :macID
      t.datetime :logTime
      t.references :client, index: true
      t.integer :duration

      t.timestamps null: false
    end
    add_foreign_key :session_logs, :clients
  end
end
