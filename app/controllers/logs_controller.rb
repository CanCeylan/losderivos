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
		#variables
		visitor_list.each do |v|
			Log.create({macID: v["macAddress"], 
						reason: v["historyLogReason"],
						hierarchy: v["MapInfo"]["mapHierarchyString"],
						mapX: v["MapCoordinate"]["x"],
						mapY: v["MapCoordinate"]["y"],
						firstTime: v["Statistics"]["firstLocatedTime"],
						lastTime: v["Statistics"]["lastLocatedTime"],
						serverTime: v["Statistics"]["currentServerTime"],
						location: Location.get_location(v["MapCoordinate"])
						})
		end
	

	end


end

    t.string   "macID",            limit: 255
    t.float    "mapX",             limit: 24
    t.float    "mapY",             limit: 24
    t.string   "hierarchy",        limit: 255
    t.string   "floor",            limit: 255
    t.datetime "firstLocatedTime"
    t.datetime "lastLocatedTime"
    t.string   "reason",           limit: 255
    t.string   "ip",               limit: 255
    t.string   "username",         limit: 255
    t.string   "dot11status",      limit: 255
    t.boolean  "isGuest",          limit: 1
