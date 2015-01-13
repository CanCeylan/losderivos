require "clockwork"
require './config/boot'
require './config/environment'

# class MyWorker
# 	include Sidekiq::Worker

# 	def perform(count)
# 		puts "Job ##{count}: Late night, so tired..."
# 	end

# 	def self.late_night_work
# 		10.times do |x|
# 			perform_async(x)
# 		end
# 	end
# end


# class HourlyWorker
# 	include Sidekiq::Worker

# 	def perform
# 		clenup_database
# 		format_hard_drive
# 	end
# end


module Clockwork

	handler do |job, time|
		puts "Hey! --> Running #{job}, at #{time}"
	end

	every(10.seconds, 'frequent.job'){HardWorker.perform('ocan',2)}

end