class Api::V1::RetentionController < ApplicationController

	def facade

	end


	def weeklyRetention
		weekly = Retention.select("DATE(firstLocatedTime),
								   COUNT(id), 
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
						   .where("client_id = #{params[:client_id]} and date(firstLocatedTime) = DATE(#{params[:logDate]})")
						   .group("DATE(#{params[:logDate]}), client_id")		

		render json: weekly						
	end

	def monthlyRetention
		monthly = Retention.select("DATE(firstLocatedTime),
									COUNT(id), 
									SUM(w1) + SUM(w2) + SUM(w3) + SUM(w4) as m1,
								    SUM(w5) + SUM(w6) + SUM(w7) + SUM(w8) as m2,
								    SUM(w9) + SUM(w10) + SUM(w11) + SUM(w12) as m3,
								    SUM(m4) as m4,
					 			    SUM(m5) as m5,
					  			    SUM(m6) as m6,
					 			    SUM(m7) as m7,
					 			    SUM(m8) as m8,
								    SUM(m9) as m9,
								    SUM(m10) as m10,
								    SUM(m11) as m11,
								    SUM(m12) as m12")
						   .where("client_id = #{params[:client_id]} and date(firstLocatedTime) = DATE(#{params[:logDate]})")
						   .group("DATE(#{params[:logDate]}), client_id")		

		render json: monthly		
	end

end
