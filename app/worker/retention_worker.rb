class RetentionWorker

	include Sidekiq::Worker
	
	def perform(deyt)

		@users = Log.select("macID, client_id, firstLocatedTime, DATE(lastLocatedTime) - DATE(firstLocatedTime) as diff")
		.where("date(lastLocatedTime) = ?", deyt)
		.group("macID, client_id, DATE(lastLocatedTime)")

		@users.each do |u| 

			retention = Retention.find_or_create_by(macID: u["macID"], client_id: u["client_id"], firstLocatedTime: u["firstLocatedTime"])

			case u["diff"]

			when 1...7
				retention.w1 = 1
			when 8..14
				retention.w2 = 1
			when 15..21
				retention.w3 = 1
			when 22..28
				retention.w4 = 1
			when 29..35
				retention.w5 = 1
			when 36..42
				retention.w6 = 1
			when 43..49
				retention.w7 = 1
			when 50..56
				retention.w8 = 1
			when 57..63
				retention.w9 = 1
			when 64..70
				retention.w10 = 1
			when 71..78
				retention.w11 = 1
			when 79..85
				retention.w12 = 1
			when 86..115 # m4
				retention.m4 = 1
			when 116..145 # m5
				retention.m5 = 1
			when 146..175	# m6
				retention.m6 = 1
			when 176..205 # m7
				retention.m7 = 1
			when 206..235 # m8
				retention.m8 = 1
			when 236..265 # m9
				retention.m9 = 1
			when 267..295 # m10
				retention.m10 = 1
			when 296..325 # m11
				retention.m11 = 1
			when 326..355 # m12
				retention.m12 = 1
			end

			retention.save

		end

	end
end
