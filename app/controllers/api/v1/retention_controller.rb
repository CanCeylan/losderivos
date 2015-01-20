class Api::V1::RetentionController < ApplicationController

	def facade

		result = {}

		result["client_id"] = params[:client_id].to_i
		frame = params[:frame].to_i

		if frame == 1  # localhost:3000/retention?client_id=1&date="2015-01-06"&week=1
			puts "weekly deyim"
			puts params[:frame]
			result["retention"] = weeklyRetention(params[:client_id], params[:date].to_date)		
		elsif frame == 0
			puts "burdayim baciii"
			result["retention"] = monthlyRetention(params[:client_id], params[:date].to_date)		
		end

		render json: result
	end

	# buradaki methodlarda su an sadece week ve month karsilastiriliyor, 
	# ama bu data 1 yilliktan daha fazla data oldugunda where statement degistirilmeli

	def weeklyRetention(client, date)

		frame = 12.times.map {|i| (date - (i+1).week).end_of_week}
		weekly = []

		frame.each do |f|
			weekly.push(calculateWeeklyRetention(client, f))
		end

		return weekly
	end


	def monthlyRetention(client, date)
		
		frame = 12.times.map {|i| (date - (i+1).month).end_of_month}
		monthly = []

		frame.each do |f|
			monthly.push(calculateMonthlyRetention(client, f))
		end

		return monthly
	end

	def calculateMonthlyRetention(client, date)
		monthly = Retention.select("DATE(firstLocatedTime) as date,
									COUNT(id) as customers, 
									SUM(CASE WHEN (w1 = 1 OR w2 = 1 OR w3 = 1 OR w4 = 1) THEN 1 ELSE 0 END) as m1,
									SUM(CASE WHEN (w5 = 1 OR w6 = 1 OR w7 = 1 OR w8 = 1) THEN 1 ELSE 0 END) as m2,
									SUM(CASE WHEN (w9 = 1 OR w10 = 1 OR w11 = 1 OR w12 = 1) THEN 1 ELSE 0 END) as m3,
								    SUM(m4) as m4,
					 			    SUM(m5) as m5,
					  			    SUM(m6) as m6,
					 			    SUM(m7) as m7,
					 			    SUM(m8) as m8,
								    SUM(m9) as m9,
								    SUM(m10) as m10,
								    SUM(m11) as m11,
								    SUM(m12) as m12")
						   .where("client_id = #{client} and month(firstLocatedTime) = month('#{date}')")
						   .group("month('#{date}'), client_id")		
		return monthly	
	end

	def calculateWeeklyRetention(client,date)
		weekly = Retention.select("DATE(firstLocatedTime) as date,
								   COUNT(id) as customers, 
								   SUM(w1) as w1,
								   SUM(w2) as w2,
								   SUM(w3) as w3,
								   SUM(w4) as w4,
								   SUM(w5) as w5,
								   SUM(w6) as w6,
								   SUM(w7) as w7,
								   SUM(w8) as w8,
								   SUM(w9) as w9,
								   SUM(w10) as w10,
								   SUM(w11) as w11,
								   SUM(w12) as w12")
						   .where("client_id = #{client} and week(firstLocatedTime) = week('#{date}')")
						   .group("week('#{date}'), client_id")		
		return weekly 
	end


end
