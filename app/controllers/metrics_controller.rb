class MetricsController < ApplicationController

	respond_to :json
	
	def getClientMetrics

	render json: Metric.where("client_id = ? and logDate between ? and ?", params[:id], params[:start], params[:end])

	end

	def getClientDensity

	LogDate =Date.yesterday
	

	render json: 

	Metric.where("client_id = ? and logDate = '#{logDate}'", params[:id])

	end


#conversion= Location.joins(:logs).select("COUNT(DISTINCT(macID)) as conversion").where("logs.client_id = ? and date(lastLocatedTime) = ? and isOutside = 0",client_id,logDate)
#newCustomers = Log.select("COUNT(DISTINCT(macID)) as newCustomers").where("client_id = ? and date(firstLocatedTime) >= date(lastLocatedTime)",client_id)
#repeatCustomers = Log.select("COUNT(DISTINCT(macID)) as repeatCustomers").where("client_id = ? and date(firstLocatedTime) < date(lastLocatedTime)",client_id)
			
	
end


