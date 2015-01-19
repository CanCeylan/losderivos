class Api::V1::RetentionController < ApplicationController

	def facade

	end

	# buradaki methodlarda su an sadece week ve month karsilastiriliyor, 
	# ama bu data 1 yilliktan daha fazla data oldugunda where statement degistirilmeli

	def weeklyRetention
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
						   .where("client_id = #{params[:client_id]} and week(firstLocatedTime) = week(#{params[:logDate]})")
						   .group("week(#{params[:logDate]}), client_id")		

		render json: weekly						
	end

	def monthlyRetention
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
						   .where("client_id = #{params[:client_id]} and month(firstLocatedTime) = month(#{params[:logDate]})")
						   .group("month(#{params[:logDate]}), client_id")		

		render json: monthly		
	end

end
