require "clockwork"
require './config/boot'
require './config/environment'

module Clockwork

	handler do |job, time|
		puts "Hey! --> Running #{job}, at #{time}"
	end

#	every(10.seconds, 'frequent.job'){HardWorker.perform_async('RECURSIVE DENEMESI',5)}
	every(30.seconds, 'log_history.job'){LogHistoryWorker.perform_async("https://learning:learning@64.103.26.61/api/contextaware/v1/location/history/clients/.json", 500, 1)}
	
end