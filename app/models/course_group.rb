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
#  group_type  :string
#

class CourseGroup < ActiveRecord::Base

  GROUP_TYPES = ['lecture', 'class', 'conversatorium', 'laboratory']

  belongs_to :subject
  belongs_to :lecturer
  has_and_belongs_to_many :users
  has_many :calendar_events
  has_many :grades

  accepts_nested_attributes_for :grades

  validates :subject, presence: true
  validates :lecturer, presence: true

  validates :start_time, :end_time, :weekday, presence: true


  def enrolled_students
    users.where(role: 'Student')
  end

end
