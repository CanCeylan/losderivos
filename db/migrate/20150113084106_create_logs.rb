class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :macID
      t.float :mapX
      t.float :mapY
      t.string :floor
      t.datetime :firstLocatedTime
      t.datetime :lastLocatedTime
      t.string :reason
      t.string :ip
      t.string :username
      t.string :dot11status
      t.boolean :isGuest
      t.references :location, index: true
      t.references :client, index: true

      t.timestamps null: false
    end
  end
end
