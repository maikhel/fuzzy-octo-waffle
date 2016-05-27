class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.integer :field_of_study_id
      t.datetime :start_date
      t.datetime :end_date
      t.string :period_type

      t.timestamps null: false
    end
  end
end
