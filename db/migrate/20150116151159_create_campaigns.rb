class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.string :company
      t.datetime :start
      t.datetime :end
      t.boolean :hasAll

      t.timestamps null: false
    end
  end
end
