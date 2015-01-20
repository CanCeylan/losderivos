class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.string :company
      t.datetime :startDate
      t.datetime :endDate
      t.boolean :hasAll

      t.timestamps null: false
    end
  end
end
