class Client < ActiveRecord::Base
	has_many :logs
	has_many :locations, dependent: :destroy
	has_many :campaigns, through: :campaign_clients
end
