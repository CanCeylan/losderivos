require 'metric_calculator'
class Api::V1::VisitController < ApplicationController
	include MetricCalculator
	respond_to :json


	def getVisit()

		client_id = params[:client_id].to_i
		startDate = params[:start].to_date
		endDate = params[:end].to_date

		tempHash = Hash.new
		array = []
		startDate.upto(endDate) do |date|

			logDate = date
			storefront_potential = getPotential(client_id,logDate).first["potential"].to_i
			storefront_conversion = getConversion(client_id,logDate).first["conversion"].to_i
			bounce = getBounce(client_id,logDate).first["bounce"].to_i
			new_customers = getNewCustomers(client_id,logDate).first["newCustomers"].to_i
			repeat_customers = getRepeatCustomers(client_id,logDate).first["repeatCustomers"].to_i
			average_shop_time = getAverageTime(client_id,logDate).first["averageTime"].to_i
			
			tempHash = {
				"date"=> logDate,
				"potential"=> storefront_potential,
				"conversion"=> storefront_conversion,
				"bounce"=> bounce,
				"new"=> new_customers,
				"repeat"=> repeat_customers,
				"average"=> average_shop_time
			}
			array.push(tempHash)

		end

		metricHash = {
			"metrics"=>array
		}

		render json: metricHash
	end

end
