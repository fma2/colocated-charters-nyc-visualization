class School < ActiveRecord::Base
	geocoded_by :full_street_address
	after_validation :geocode

	belongs_to :building
end
