class MetricsWorker

	include Sidekiq::Worker

	def perform(deyt)

		logDate = deyt
		client_list = Client.select(:id).distinct

		client_list.each do |c|


			client_id=c["id"]
			potential= Location.joins(:logs).select("COUNT(DISTINCT(macID)) as potential").where("logs.client_id = ? and date(lastLocatedTime) = ? and isOutside = 1",client_id,logDate)
			conversion= Location.joins(:logs).select("COUNT(DISTINCT(macID)) as conversion").where("logs.client_id = ? and date(lastLocatedTime) = ? and isOutside = 0",client_id,logDate)

			newCustomers = Log.select("COUNT(DISTINCT(macID)) as newCustomers").where("client_id = ? and date(lastLocatedTime) = ? and date(firstLocatedTime) >= date(lastLocatedTime)",client_id,logDate)
			repeatCustomers = Log.select("COUNT(DISTINCT(macID)) as repeatCustomers").where("client_id = ? and date(lastLocatedTime) = ? and date(firstLocatedTime) < date(lastLocatedTime)",client_id,logDate)

			averageTime = SessionLog.select("SUM(duration)/COUNT(macID) as averageTime").where("client_id = ? and date(pointer) = ? and isClosed = 1",client_id,logDate)

			bounce = SessionLog.select("COUNT(macID) as bounce").where("client_id = ? and date(pointer) = ? and duration < 60 and isClosed = 1",client_id,logDate)

			weeklyRetention = Retention.select("SUM(w1)/COUNT(macID) as weeklyRetention").where("client_id = #{client_id} and date(firstLocatedTime) = date_sub('#{logDate}', INTERVAL 1 week)")
			monthlyRetention = Retention.select("SUM(CASE WHEN date(firstLocatedTime) = date_sub('#{logDate}' , INTERVAL 1 month)
				and ((w1= 1) or (w2=1) or (w3=1) or (w4=1)) and client_id = #{client_id} THEN 1 ELSE 0 END) /
			SUM(CASE WHEN client_id = #{client_id} and date(firstLocatedTime) = date_sub('#{logDate}' , INTERVAL 1 MONTH) THEN 1 ELSE 0 END) as monthlyRetention")
			biMonthlyRetention = Retention.select("SUM(CASE WHEN date(firstLocatedTime) = date_sub('#{logDate}' , INTERVAL 2 month)
				and ((w1= 1) or (w2=1) or (w3=1) or (w4=1)) and client_id = #{client_id} THEN 1 ELSE 0 END) /
			SUM(CASE WHEN client_id = #{client_id} and date(firstLocatedTime) = date_sub('#{logDate}' , INTERVAL 2 MONTH) THEN 1 ELSE 0 END) as biMonthlyRetention")


			metric = Metric.create({ logDate: logDate,
				client_id: client_id,
				potential: potential.first["potential"],
				conversion: conversion.first["conversion"],
				newCustomers: newCustomers.first["newCustomers"],
				repeatCustomers: repeatCustomers.first["repeatCustomers"],
				averageTime: averageTime.first["averageTime"],
				bounce: bounce.first["bounce"],
				weeklyRetention: weeklyRetention.first["weeklyRetention"],
				monthlyRetention: monthlyRetention.first["monthlyRetention"],
				biMonthlyRetention: biMonthlyRetention.first["biMonthlyRetention"]
				})

			metric.save

		end

	end

end