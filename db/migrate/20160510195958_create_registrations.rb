class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :field_of_study_id

      t.timestamps null: false
    end
  end
end
