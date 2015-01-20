class Location < ActiveRecord::Base
  belongs_to :client, dependent: :destroy
  has_many :logs

  	def self.get_location(x, y, client)
		Location.all.where(:client_id => client).each do |zone|
			if zone.minX <= x &&
			   x <= zone.maxX &&
			   zone.minY <= y &&
			   y <= zone.maxY
				return zone.id
			end	
		end
		1
	end
end
