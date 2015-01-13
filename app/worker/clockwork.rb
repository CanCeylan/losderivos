require "clockwork"
require './config/boot'
require './config/environment'

module Clockwork

	handler do |job, time|
		puts "Hey! --> Running #{job}, at #{time}"
	end

	every(10.seconds, 'frequent.job'){HardWorker.perform_async('ocan',2)}
	every(1.day, 'log_history.job'){LogHistory.perform_async()}

end