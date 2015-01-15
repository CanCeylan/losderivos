class CreateRetentions < ActiveRecord::Migration
  def change
    create_table :retentions do |t|
      t.string :macID
      t.references :client, index: true
      t.datetime :firstLocatedTime
      t.boolean :w1
      t.boolean :w2
      t.boolean :w3
      t.boolean :w4
      t.boolean :w5
      t.boolean :w6
      t.boolean :w7
      t.boolean :w8
      t.boolean :w9
      t.boolean :w10
      t.boolean :w11
      t.boolean :w12
      t.boolean :m4
      t.boolean :m5
      t.boolean :m6
      t.boolean :m7
      t.boolean :m8
      t.boolean :m9
      t.boolean :m10
      t.boolean :m11
      t.boolean :m12

      t.timestamps null: false
    end
    add_foreign_key :retentions, :clients
  end
end
