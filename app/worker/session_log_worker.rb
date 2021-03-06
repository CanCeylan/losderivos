class SessionLogWorker

	include Sidekiq::Worker
	
	def perform(deyt)

		# Sadece belirli zaman iersiinde gelen userlarin macidlerini cekmek gerekli
		# location ile join edip sadece iceridekileri burada da filtreleyebiliriz?
		@users = Log.select("DISTINCT(macID)").where("date(lastLocatedTime) = ?", deyt)

		@users.each do |u| 

			@logs = Log.where("macID = ? and location_id != 0", u["macID"]).order(lastLocatedTime: :asc)

			@logs.each do |l|

				location = Location.find(l["location_id"])

				if !location.isOutside
					pointer = l["lastLocatedTime"]		
					session = SessionLog.where(macID: l["macID"]).last   
					if session.nil? #new session starts
						session = SessionLog.create({logTime: pointer, 
													macID: l["macID"], 
													pointer: pointer, 
													isClosed: false,
													client_id: l["client_id"],
													location_id: l["location_id"]})
					else 			#if session already started	
						if session.pointer.present? 
							difference = pointer - session.pointer
							if difference <= 300
								session.duration += difference
								session.pointer = pointer
							else # session ends
								session.isClosed = true
								SessionLog.create({logTime: pointer, 
													macID: l["macID"], 
													pointer: pointer, 
													isClosed: false,
													client_id: l["client_id"],
													location_id: l["location_id"]})
							end
							session.save
						end
					end
				end
			end
		end
	end
end
