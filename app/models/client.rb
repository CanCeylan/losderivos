class Client < ActiveRecord::Base
	has_many :logs
	has_many :locations, dependent: :destroy
end
