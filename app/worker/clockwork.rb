require "clockwork"
require './config/boot'
require './config/environment'

module Clockwork

	handler do |job, time|
		puts "Hey! --> Running #{job}, at #{time}"
	end

	deyt = "2015-01-19"

	#every(100.seconds, 'log_history.job'){LogHistoryWorker.perform_async("https://learning:learning@64.103.26.61/api/contextaware/v1/location/history/clients/.json", 500, 1)}
	every(100.seconds, 'session_log.job'){SessionLogWorker.perform_async(deyt)}
	every(100.seconds, 'retention.job'){RetentionWorker.perform_async(deyt)}
	every(100.seconds, 'metrics.job'){MetricsWorker.perform_async(deyt)}

end