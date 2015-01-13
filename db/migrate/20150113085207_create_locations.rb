class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.references :client, index: true
      t.string :region
      t.float :minX
      t.float :maxX
      t.float :minY
      t.float :maxY
      t.boolean :isOutside

      t.timestamps null: false
    end
    add_foreign_key :locations, :clients
  end
end
