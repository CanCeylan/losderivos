class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.date :logDate
      t.references :client, index: true
      t.integer :potential
      t.integer :conversion
      t.integer :new
      t.integer :repeat
      t.integer :averageTime
      t.integer :bounce
      t.float :weeklyRetention
      t.float :monthlyRetention
      t.float :biMonthlyRetention

      t.timestamps null: false
    end
    add_foreign_key :metrics, :clients
  end
end
