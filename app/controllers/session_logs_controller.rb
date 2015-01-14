class SessionLogsController < ApplicationController

	def ocan

		HardWorker.perform_async('erbil', 15)
		
		render json: "ocakkkn"
	end

end
