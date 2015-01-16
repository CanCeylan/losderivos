class CreateCampaignClients < ActiveRecord::Migration
  def change
    create_table :campaign_clients do |t|
      t.references :campaign, index: true
      t.references :client, index: true

      t.timestamps null: false
    end
    add_foreign_key :campaign_clients, :campaigns
    add_foreign_key :campaign_clients, :clients
  end
end
