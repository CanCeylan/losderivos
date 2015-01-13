class SessionLogsController < ApplicationController

	def ocan

		HardWorker.perform_async('bob', 5)
		
		render json: "ocan"
	end

end
