class CreateCalendarEvents < ActiveRecord::Migration
  def change
    create_table :calendar_events do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :course_group_id

      t.timestamps null: false
    end
  end
end
