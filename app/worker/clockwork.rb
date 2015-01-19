require "clockwork"
require './config/boot'
require './config/environment'

module Clockwork

	handler do |job, time|
		puts "Hey! --> Running #{job}, at #{time}"
	end

	deyt = "2015-01-19"

	every(1.day, 'log_history.job', :at => '00:00'){LogHistoryWorker.perform_async("https://learning:learning@64.103.26.61/api/contextaware/v1/location/history/clients/.json", 500, 1)}
	every(1.day, 'session_log.job', :at => '01:00'){SessionLogWorker.perform_async}
	every(1.day, 'retention.job', :at => '02:00'){RetentionWorker.perform_async(deyt)}
	every(1.day, 'metrics.job', :at => '03:00'){MetricsWorker.perform_async(deyt)}

end