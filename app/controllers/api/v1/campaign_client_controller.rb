class Api::V1::CampaignClientController < ApplicationController

	def new
		@cc = CampaignClient.new
	end

	def create
		@cc = CampaignClient.new(campaign_id: params[:campaign_id],	
								 client_id: params[:client_id])

		@cc.save
		render json: @cc
	end

end	
