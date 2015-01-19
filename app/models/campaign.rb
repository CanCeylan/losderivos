class Campaign < ActiveRecord::Base
	has_many :campaign_clients
	has_many :clients, through: :campaign_clients
end
