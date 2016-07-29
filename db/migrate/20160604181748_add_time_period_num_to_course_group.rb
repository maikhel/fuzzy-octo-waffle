class AddTimePeriodNumToCourseGroup < ActiveRecord::Migration
  def change
    add_column :course_groups, :time_period_num, :integer
  end
end
