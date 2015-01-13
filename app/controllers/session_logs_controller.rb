class SessionLogsController < ApplicationController

	def ocan

		HardWorker.perform_async('bobcan', 15)
		
		render json: "ocakkkn"
	end

end
