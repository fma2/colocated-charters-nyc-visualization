class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
			t.string :ats_system_code
			t.string :location_code
			t.string :location_name
			t.string :managed_by_name
			t.string :location_type_description
			t.string :location_category_description
			t.string :grades
			t.string :grades_final
			t.string :open_date
			t.string :status_description
			t.string :building_code
			t.string :primary_address
			t.string :city
			t.string :state_code
			t.string :zip
			t.string :geographical_district_code
			t.string :administrative_district_code
			t.string :administrative_district_location_code
			t.string :administrative_district_name
			t.string :same_address_as_another_school	
      t.timestamps
    end
  end
end
