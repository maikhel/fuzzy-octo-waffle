# == Schema Information
#
# Table name: course_groups
#
#  id              :integer          not null, primary key
#  start_time      :time
#  end_time        :time
#  weekday         :integer
#  subject_id      :integer
#  lecturer_id     :integer
#  max_limit       :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  group_type      :string
#  time_period_num :integer
#

class CourseGroup < ActiveRecord::Base
  GROUP_TYPES = %w[lecture class conversatorium laboratory].freeze

  belongs_to :subject
  belongs_to :lecturer
  has_and_belongs_to_many :users
  has_many :calendar_events
  has_many :grades

  accepts_nested_attributes_for :grades

  validates :subject, presence: true
  validates :lecturer, presence: true

  validates :time_period_num, :weekday, presence: true
  # rubocop:disable Style/Lambda
  scope :from_semester, ->(semester_id) {
    includes(:subject).where('subjects.semester_id = ?', semester_id).references(:subject)
  }
  # rubocop:enable Style/Lambda

  def enrolled_students
    users.where(role: 'Student')
  end

  def adjust_dates
    hours = [
      [8.00, 9.30],
      [9.45, 11.15],
      [11.30, 13.00],
      [13.15, 14.45],
      [15.00, 16.30],
      [16.45, 18.15],
      [18.30, 20.00]
    ]
    chosen = hours[time_period_num]
    self.start_time = Time.now.change(hour: chosen[0])
    self.end_time = Time.now.change(hour: chosen[1])
    save
  end
end
