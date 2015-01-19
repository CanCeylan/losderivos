class AddCampaignTypeToCampaigns < ActiveRecord::Migration
  def change
  	add_column :campaigns, :campaignType, :integer
  	change_column_default(:campaigns, :campaignType, 1) 
  end
end
