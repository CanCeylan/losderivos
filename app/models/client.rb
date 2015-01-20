class Client < ActiveRecord::Base
	has_many :logs
	has_many :locations
	has_many :campaign_clients
	has_many :campaigns, through: :campaign_clients
end
