class MetricsWorker

	include Sidekiq::Worker

	def perform()
		puts "Basliyoruum #{name} reaally hard work #{count}"


		client_list = Client.select(:id).distinct

		client_list.each do |c|

			logDate= Date.today
			client_id=c.id
			potential= Location.joins(:logs).select("COUNT(DISTINCT(macID))").where("client_id = ? and date(lastLocatedTime) = ? and isOutside = 1",client_id,logDate)
			conversion= Location.joins(:logs).select("COUNT(DISTINCT(macID))").where("client_id = ? and date(lastLocatedTime) = ? and isOutside = false",client_id,logDate)
			newCustomers = Log.select("COUNT(DISTINCT(macID))").where("client_id = ? and date(firstLocatedTime) >= date(lastLocatedTime)",client_id)
			repeatCustomers = Log.select("COUNT(DISTINCT(macID))").where("client_id = ? and date(firstLocatedTime) < date(lastLocatedTime)",client_id)
			averageTime = SessionLog.select("SUM(duration)/COUNT(macID)").where("client_id = ? and date(logTime) = ? and isClosed = 1",client_id,logDate) 
			bounce = SessionLog.select("COUNT(DISTINCT(macID))").where("client_id = ? and date(logTime) = ? and duration < 60 and isClosed = 1",client_id,logDate) 


			Metric.create({ logDate: logDate,
				client_id: client_id,
				potential: potential,
				conversion: conversion,
				newCustomers: newCustomers,
				repeatCustomers: repeatCustomers,
				averageTime: averageTime,
				bounce: bounce,
				weeklyRetention: 1.1, #weeklyRetention,
				monthlyRetention: 1.1, #monthlyRetention,
				biMonthlyRetention: 1.1 #biMonthlyRetention
				})

		end

	end

end