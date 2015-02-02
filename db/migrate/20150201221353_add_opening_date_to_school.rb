class AddOpeningDateToSchool < ActiveRecord::Migration
  def change
  	add_column :schools, :opening_date, :date

  end
end
