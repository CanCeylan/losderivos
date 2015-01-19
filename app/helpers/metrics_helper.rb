module MetricsHelper

	def getPotential(client_id,logDate)
		potential= Location.joins(:logs).select("COUNT(DISTINCT(macID)) as potential").where("logs.client_id = ? and date(lastLocatedTime) = ? and isOutside = 1",client_id,logDate)
	end

	def getConversion(client_id,logDate)
		conversion= Location.joins(:logs).select("COUNT(DISTINCT(macID)) as conversion").where("logs.client_id = ? and date(lastLocatedTime) = ? and isOutside = 0",client_id,logDate)
	end

	def getNewCustomers(client_id,logDate)
		newCustomers = Log.select("COUNT(DISTINCT(macID)) as newCustomers").where("client_id = ? and date(lastLocatedTime) = ? and date(firstLocatedTime) >= date(lastLocatedTime)",client_id,logDate)
	end

	def getRepeatCustomers(client_id,logDate)
		repeatCustomers = Log.select("COUNT(DISTINCT(macID)) as repeatCustomers").where("client_id = ? and date(lastLocatedTime) = ? and date(firstLocatedTime) < date(lastLocatedTime)",client_id,logDate)
	end

	def getAverageTime(client_id,logDate)
		averageTime = SessionLog.select("SUM(duration)/COUNT(macID) as averageTime").where("client_id = ? and date(pointer) = ? and isClosed = 1",client_id,logDate) 
	end
end
