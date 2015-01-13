class Log < ActiveRecord::Base
	belongs_to: location
	belongs_to: client
end
