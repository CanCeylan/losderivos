class Api::V1::OverviewController < ApplicationController
	respond_to :json

	def getOverview

	

	end

end

	# respond_to :json
	
	# def getClientMetrics

	# render json: Metric.where("client_id = ? and logDate between ? and ?", params[:id], params[:start], params[:end])

	# end

# puts JSON.pretty_generate([1, 2, {"a"=>3.141}, false, true, nil, 4..10])
# [
#   1,
#   2,
#   {
#     "a": 3.141
#   },
#   false,
#   true,
#   null,
#   {
#     "json_class": "Range",
#     "data": [
#       4,
#       10,
#       false
#     ]
#   }
# ]

# {
#   "client_id": "4",
#   "storefront_potential": "23",
#   "storefront_conversion": ".45",
#   "new_customers": "34",
#   "repeat_customers": "22",
#   "average_shop_time": "14",
#   "hourly_traffic": [
#     {
#       "time": "9",
#       "new": "2",
#       "repeat": "1"
#     },
#     {
#       "time": "10",
#       "new": "6",
#       "repeat": "9"
#     },
#     {
#       "time": "11",
#       "new": "10",
#       "repeat": "15"
#     },
#     null,
#     null,
#     null,
#     null,
#     null,
#     null,
#     null,
#     null,
#     null,
#     null,
#     null,
#     null,
#     null,
#     {
#       "time": "16",
#       "new": "59",
#       "repeat": "35"
#     }
#   ]
# }