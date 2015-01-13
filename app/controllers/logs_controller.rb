class LogsController < ApplicationController

	def add_log

		resource = RestClient::Resource.new(
											"https://learning:learning@64.103.26.61/api/contextaware/v1/location/history/clients/00:00:2a:01:00:0f.json",
											:timeout => -1,
											:open_timeout => -1)
		response = resource.get  :params => {sortBy: "lastLocatedTime:desc", pageSize: 500, page: 2}

		totalPages = JSON.parse(response)["Locations"]["totalPages"]
		currentPage = JSON.parse(response)["Locations"]["currentPage"]

		puts response
		visitor_list = JSON.parse(response)["Locations"]["entries"]

		visitor_list.each do |v|
			Log.create({macID: v["macAddress"], 
						reason: v["historyLogReason"],
						hierarchy: v["MapInfo"]["mapHierarchyString"],
						mapX: v["MapCoordinate"]["x"],
						mapY: v["MapCoordinate"]["y"],
						firstLocatedTime: v["Statistics"]["firstLocatedTime"],
						lastLocatedTime: v["Statistics"]["lastLocatedTime"],
						ip: v["ipAddress"],
						username: v["userName"],
						dot11status: v["dot11Status"],
						isGuest: v["guestUser"],
						})
		end
	

	end


end
