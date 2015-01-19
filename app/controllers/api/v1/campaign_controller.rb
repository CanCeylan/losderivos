class Api::V1::CampaignController < ApplicationController

	def new
		@campaign = Campaign.new
	end

	def create
		hasAll = params[:hasAll].to_i

		@campaign = Campaign.new(name: params[:name],
							 	 company: params[:company],
							 	 startDate: params[:startDate],
							 	 endDate: params[:endDate],
							 	 campaignType: params[:type],
							 	 hasAll: hasAll)

		@campaign.save

		if hasAll == 1
			clients = Client.where(name: params[:company].to_s)

			clients.each do |c|
				CampaignClient.create({client_id: c.id, 
									   campaign_id: @campaign.id})
			end		
		else
			CampaignClient.create({client_id: params[:client_id], 
								   campaign_id: @campaign.id})
		end

		render json: @campaign
	end
end

