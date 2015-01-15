class MetricsWorker

	include Sidekiq::Worker

	def perform()
		puts "Basliyoruum"


		client_list = Client.select(:id).distinct

		client_list.each do |c|

			logDate= Date.today
			client_id=c["id"]
			potential= Location.joins(:logs).select("COUNT(DISTINCT(macID)) as potential").where("logs.client_id = ? and date(lastLocatedTime) = ? and isOutside = 1",client_id,logDate)
			conversion= Location.joins(:logs).select("COUNT(DISTINCT(macID)) as conversion").where("logs.client_id = ? and date(lastLocatedTime) = ? and isOutside = 0",client_id,logDate)
			newCustomers = Log.select("COUNT(DISTINCT(macID)) as newCustomers").where("client_id = ? and date(firstLocatedTime) >= date(lastLocatedTime)",client_id)
			repeatCustomers = Log.select("COUNT(DISTINCT(macID)) as repeatCustomers").where("client_id = ? and date(firstLocatedTime) < date(lastLocatedTime)",client_id)
			averageTime = SessionLog.select("SUM(duration)/COUNT(macID) as averageTime").where("client_id = ? and date(pointer) = ? and isClosed = 1",client_id,logDate) 
			bounce = SessionLog.select("COUNT(macID) as bounce").where("client_id = ? and date(pointer) = ? and duration < 60 and isClosed = 1",client_id,logDate) 

			metric = Metric.create({ logDate: logDate,
				client_id: client_id,
				potential: potential.first["potential"],
				conversion: conversion.first["conversion"],
				newCustomers: newCustomers.first["newCustomers"],
				repeatCustomers: repeatCustomers.first["repeatCustomers"],
				averageTime: averageTime.first["averageTime"],
				bounce: bounce.first["bounce"],
				weeklyRetention: 1.1, #weeklyRetention,
				monthlyRetention: 1.1, #monthlyRetention,
				biMonthlyRetention: 1.1 #biMonthlyRetention
				})

			metric.save

		end

	end

end