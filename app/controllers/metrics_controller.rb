class MetricsController < ApplicationController

	def writeMetrics


		client_list = Client.all

		client_list.each do |c|

			logDate= Date.today
			client_id=c.id
			potential= Location.joins(:logs).select("COUNT(DISTINCT(macID))").where("client_id = ? and date(lastLocatedTime) = ? and isOutside = true",client_id,logDate)
			conversion= Location.joins(:logs).select("COUNT(DISTINCT(macID))").where("date(lastLocatedTime) = ? and isOutside = false",logDate)

			Metric.create({ logDate: logDate,
				client_id: client_id,
				potential: 1, potential,
				conversion: 1, conversion,
				newCustomers: 1, #newCustomers,
				repeatCustomers: 1, #repeatCustomers,
				averageTime: 1, #averageTime,
				bounce: 1, #bounce,
				weeklyRetention: 1.1, #weeklyRetention,
				monthlyRetention: 1.1, #monthlyRetention,
				biMonthlyRetention: 1.1 #biMonthlyRetention
				})

		end

	end


end


