class RetentionWorker

	include Sidekiq::Worker
	
	def perform(deyt)

		@users = Log.select("macID, client_id, firstLocatedTime, DATE(lastLocatedTime) - DATE(firstLocatedTime) as diff")
		.where("date(lastLocatedTime) = ?", deyt)
		.group("macID, client_id, DATE(lastLocatedTime)")

		@users.each do |u| 

			retention = Retention.find_or_create_by(macID: u["macID"], client_id: u["client_id"], firstLocatedTime: u["firstLocatedTime"])

			diff = u["diff"]%7

			case diff

			when 1
				retention.w1 = 1
			when 2
				retention.w2 = 1
			when 3
				retention.w3 = 1
			when 4
				retention.w4 = 1
			when 5
				retention.w5 = 1
			when 6
				retention.w6 = 1
			when 7
				retention.w7 = 1
			when 8
				retention.w8 = 1
			when 9
				retention.w9 = 1
			when 10
				retention.w10 = 1
			when 11
				retention.w11 = 1
			when 12
				retention.w12 = 1
			when 13..16 # m4
				retention.m4 = 1
			when 17..20 # m5
				retention.m5 = 1
			when 21..24	# m6
				retention.m6 = 1
			when 25..28 # m7
				retention.m7 = 1
			when 29..31 # m8
				retention.m8 = 1
			when 32..35 # m9
				retention.m9 = 1
			when 36..39 # m10
				retention.m10 = 1
			when 40..43 # m11
				retention.m11 = 1
			when 44..47 # m12
				retention.m12 = 1
			end

			retention.save

		end

	end
end
