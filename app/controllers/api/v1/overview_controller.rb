require 'metric_calculator'
class Api::V1::OverviewController < ApplicationController
	include MetricCalculator
	respond_to :json

	def getOverview()

		client_id = params[:client_id].to_i
		logDate = params[:date].to_date
		storefront_potential = getPotential(client_id,logDate).first["potential"].to_i
		storefront_conversion = getConversion(client_id,logDate).first["conversion"].to_i
		new_customers = getNewCustomers(client_id,logDate).first["newCustomers"].to_i
		repeat_customers = getRepeatCustomers(client_id,logDate).first["repeatCustomers"].to_i
		average_shop_time = getAverageTime(client_id,logDate).first["averageTime"].to_i

		hourly_traffic = Location.joins(:logs).select("HOUR(logs.lastlocatedTime) as time,
			COUNT(DISTINCT CASE WHEN date(logs.firstLocatedTime) >= date(logs.lastLocatedTime) THEN logs.macID ELSE NULL END) as newcustomer,
			COUNT(DISTINCT CASE WHEN date(logs.firstLocatedTime) < date(logs.lastLocatedTime) THEN logs.macID ELSE NULL END) as repeatcustomer").where("logs.client_id = ? 
			and date(logs.lastLocatedTime) = ? and isOutside = 0",client_id,logDate).group("HOUR(logs.lastlocatedTime)")

		density =[]
		hourly_traffic.each do |h|
		density.push(h)
		end

		tempHash = {
			"client_id"=>client_id,
			"storefront_potential"=>storefront_potential,
			"storefront_conversion"=>storefront_conversion,
			"new_customers"=>new_customers,
			"repeat_customers"=>repeat_customers,
			"average_shop_time"=>average_shop_time
			}
		tempHash["hourly_traffic"] =density

		render json: tempHash
	end

end