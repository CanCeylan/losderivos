class HardWorker

	include Sidekiq::Worker

	def perform(name, count)
		puts "Basliyoruum #{name} reaally hard work #{count}"

		if count > 0
			count -= 1
			perform('erbil burada', count)
		end

	end

end