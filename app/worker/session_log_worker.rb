class LogHistoryWorker

	include Sidekiq::Worker

	def perform()

		#
		@logs = Log.order(lastTime: :asc).first(5000)

		@logs.each do |l|
			
			pointer = l["lastTime"]		
			session = SessionLog.where(macID: l["mac_id"]).last   

			if session.nil? #new session starts
				session = SessionLog.find_or_create_by({logTime: pointer, macID: l["mac_id"], pointer: pointer, isClosed: false})
			else	
				if session.pointer.present? #if session already started
					difference = pointer - session.pointer
					if difference <= 300
						session.duration += difference
						session.pointer = pointer
					else # session ends
						session.isClosed = true
						SessionLog.create({logTime: pointer, macID: l["mac_id"], pointer: pointer})
					end
					session.save
				end
			end
		end

	end




end