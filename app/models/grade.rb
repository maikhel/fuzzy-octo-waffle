# == Schema Information
#
# Table name: grades
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  course_group_id :integer
#  value           :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Grade < ActiveRecord::Base

  GRADE_VALUES = [2.0,3.0,3.5,4.0,4.5,5.0]

  belongs_to :user
  belongs_to :course_group

  validates :user, presence: true
  validates :course_group, presence: true
  validates :value, inclusion: { in: Grade::GRADE_VALUES }

end
