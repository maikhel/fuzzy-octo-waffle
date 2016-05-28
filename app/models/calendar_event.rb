# == Schema Information
#
# Table name: calendar_events
#
#  id              :integer          not null, primary key
#  start_date      :datetime
#  end_date        :datetime
#  course_group_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class CalendarEvent < ActiveRecord::Base

  belongs_to :course_group

  validates :course_group, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

end
