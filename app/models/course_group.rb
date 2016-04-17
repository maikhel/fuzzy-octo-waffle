# == Schema Information
#
# Table name: course_groups
#
#  id          :integer          not null, primary key
#  start_time  :time
#  end_time    :time
#  weekday     :integer
#  subject_id  :integer
#  lecturer_id :integer
#  max_limit   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class CourseGroup < ActiveRecord::Base

  belongs_to :subject
  belongs_to :lecturer, class_name: 'User'

  validates :start_time, :end_time, :weekday, presence: true

end
