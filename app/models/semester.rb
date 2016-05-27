# == Schema Information
#
# Table name: semesters
#
#  id                :integer          not null, primary key
#  field_of_study_id :integer
#  start_date        :datetime
#  end_date          :datetime
#  period_type       :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Semester < ActiveRecord::Base

  belongs_to :field_of_study
  has_many :subjects, dependent: :destroy

  validates :field_of_study, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

end