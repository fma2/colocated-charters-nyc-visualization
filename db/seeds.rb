# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'csv'

School.delete_all 
Building.delete_all

csv_text = File.read('db/colocated-charters-and-schools.csv')
csv = CSV.parse(csv_text, :headers => true)

csv.each do |row|
  School.create!(row.to_hash)
end

all_schools = School.all

#first iteration over all schools to add full_street_address
all_schools.each do |school|
	full_address = "#{school.primary_address}, #{school.city}, #{school.state_code} #{school.zip}"
	school.update(full_street_address:full_address)
	school.save
end

# fix geocoding problem
while School.where(latitude: nil).count > 0
	schools_without_latlong = School.where(latitude: nil)
	schools_without_latlong.each do |school|
		full_address = "#{school.primary_address}, #{school.city}, #{school.state_code} #{school.zip}"
		school.update(full_street_address: full_address)
		school.save
	end
end

# add formatted opening date to schools
all_schools.each do |school|
	date = Chronic.parse(school.open_date)
	school.update(opening_date: date.to_date)
	school.save
end

# add building information
all_schools.each do |school|
	building = Building.find_or_create_by(primary_address: school.primary_address)
	building.schools << school
end