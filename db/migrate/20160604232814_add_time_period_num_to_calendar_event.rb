class AddTimePeriodNumToCalendarEvent < ActiveRecord::Migration
  def change
    add_column :calendar_events, :time_period_num, :integer
  end
end
