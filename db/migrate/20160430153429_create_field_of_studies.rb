class CreateFieldOfStudies < ActiveRecord::Migration
  def change
    create_table :field_of_studies do |t|
      t.string :title, default: ''
      t.string :mode, default: ''
      t.string :degree, default: ''
      t.integer :dean_id
      t.integer :faculty_id

      t.timestamps null: false
    end
  end
end
