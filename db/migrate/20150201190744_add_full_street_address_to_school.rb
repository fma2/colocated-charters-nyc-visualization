class AddFullStreetAddressToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :full_street_address, :string
  end
end
