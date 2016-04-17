class CreateCourseGroups < ActiveRecord::Migration
  def change
    create_table :course_groups do |t|
      t.time :start_time
      t.time :end_time
      t.integer :weekday
      t.integer :subject_id
      t.integer :lecturer_id
      t.integer :max_limit

      t.timestamps null: false
    end
  end
end
