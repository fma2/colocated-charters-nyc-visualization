class AddBuildingIdToSchool < ActiveRecord::Migration
  def change
  	add_column :schools, :building_id, :integer
  end
end
