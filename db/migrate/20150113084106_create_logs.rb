class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :macID
      t.float :mapX
      t.float :mapY
      t.string :hierarchy
      t.string :floor
      t.datetime :firstLocatedTime
      t.datetime :lastLocatedTime
      t.string :reason
      t.string :ip
      t.string :username
      t.string :dot11status
      t.boolean :isGuest

      t.timestamps null: false
    end
  end
end
