class LogHistoryWorker

	include Sidekiq::Worker

	def perform(url, pageSize, page)

		resource = RestClient::Resource.new(
			url,
			:timeout => -1,
			:open_timeout => -1)
		response = resource.get  :params => {sortBy: "lastLocatedTime:desc", pageSize: pageSize, page: page}

		totalPages =  JSON.parse(response)["Locations"]["totalPages"]
		currentPage = JSON.parse(response)["Locations"]["currentPage"]

		if currentPage <= totalPages 
			visitor_list = JSON.parse(response)["Locations"]["entries"]
			logYazici(visitor_list)	
			currentPage += 1
			perform(url, pageSize, currentPage)
		end
	end


	def logYazici(visitor_list)
		visitor_list.each do |v|

				@client = Client.find_by_branch(v["MapInfo"]["mapHierarchyString"]) 
				@location = Location.find_or_create_by({id: Location.get_location(v["MapCoordinate"]["x"], v["MapCoordinate"]["y"], @client.id)})

				Log.create({macID: v["macAddress"], 
					reason: v["historyLogReason"],
					mapX: v["MapCoordinate"]["x"],
					mapY: v["MapCoordinate"]["y"],
					firstLocatedTime: v["Statistics"]["firstLocatedTime"],
					lastLocatedTime: v["Statistics"]["lastLocatedTime"],
					ip: v["ipAddress"],
					username: v["userName"],
					dot11status: v["dot11Status"],
					isGuest: v["guestUser"],
					floor: v["MapInfo"]["floorRefId"],
					client: @client,
					location: @location
					})
			end
	end


end