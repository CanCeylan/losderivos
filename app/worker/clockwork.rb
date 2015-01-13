require "clockwork"

class MyWorker
	include Sidekiq::Worker

	def perform(count)
		puts "Job ##{count}: Late night, so tired..."
	end

	def self.late_night_work
		10.times do |x|
			perform_async(x)
		end
	end
end


class HourlyWorker
	include Sidekiq::Worker

	def perform
		clenup_database
		format_hard_drive
	end
end


module Clockwork

	every 1.day, 'my_worker.late_night_work', :at => '4:30 am' do
		MyWorker.late_night_work
	end

	every 1.hour do
		HourlyWorker.perform_async
	end

end