class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
    	t.string :primary_address
      t.timestamps
    end
  end
end
