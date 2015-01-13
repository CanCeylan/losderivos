class HardWorker

	include Sidekiq::Worker

	def perform(name, count)
		puts 'Doing reaally hard work'
	end

end