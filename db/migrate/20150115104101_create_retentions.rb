class CreateRetentions < ActiveRecord::Migration
  def change
    create_table :retentions do |t|
      t.string :macID
      t.references :client, index: true
      t.datetime :firstLocatedTime
      t.integer :w1
      t.integer :w2
      t.integer :w3
      t.integer :w4
      t.integer :w5
      t.integer :w6
      t.integer :w7
      t.integer :w8
      t.integer :w9
      t.integer :w10
      t.integer :w11
      t.integer :w12
      t.integer :m4
      t.integer :m5
      t.integer :m6
      t.integer :m7
      t.integer :m8
      t.integer :m9
      t.integer :m10
      t.integer :m11
      t.integer :m12

      t.timestamps null: false
    end
    add_foreign_key :retentions, :clients
  end
end
