class SchoolsController < ApplicationController

	def index
		@schools = School.all
		@geojson = Array.new
		@schools.each do |school|
			@geojson << {
				type: 'Feature',
				geometry: {
					type: 'Point',
					coordinates: [school.longitude, school.latitude]
				},
				properties: {
					ats_system_code: school.ats_system_code,
					location_code: school.location_code,
					location_name: school.location_name,
					managed_by_name: school.managed_by_name,
					location_type_description: school.location_type_description,
					location_category_description: school.location_category_description,
					grades: school.grades,
					grades_final: school.grades_final,
					open_date: school.open_date,
					status_description: school.status_description,
					building_code: school.building_code,
					primary_address: school.primary_address,
					city: school.city,
					state_code: school.state_code,
					zip: school.zip,
					geographical_district_code: school.geographical_district_code,
					administrative_district_code: school.administrative_district_code,
					administrative_district_location_code: school.administrative_district_location_code,
					administrative_district_name: school.administrative_district_name,
					same_address_as_another_school: school.same_address_as_another_school
				}
			}
		end
		respond_to do |format|
			format.html
			format.json { render json: @geojson }
		end
	end

	def showjson
		@schools = School.all
		@geojson = Array.new
		@schools.each do |school|
			@geojson << {
				type: 'Feature',
				geometry: {
					type: 'Point',
					coordinates: [school.longitude, school.latitude]
				},
				properties: {
					ats_system_code: school.ats_system_code,
					location_code: school.location_code,
					location_name: school.location_name,
					managed_by_name: school.managed_by_name,
					location_type_description: school.location_type_description,
					location_category_description: school.location_category_description,
					grades: school.grades,
					grades_final: school.grades_final,
					open_date: school.open_date,
					status_description: school.status_description,
					building_code: school.building_code,
					primary_address: school.primary_address,
					city: school.city,
					state_code: school.state_code,
					zip: school.zip,
					geographical_district_code: school.geographical_district_code,
					administrative_district_code: school.administrative_district_code,
					administrative_district_location_code: school.administrative_district_location_code,
					administrative_district_name: school.administrative_district_name,
					same_address_as_another_school: school.same_address_as_another_school,
					opening_date: school.opening_date
				}
			}
		end
		respond_to do |format|
			format.html
			format.json { render json: @geojson }
		end
	end

end
