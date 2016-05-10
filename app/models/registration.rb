# == Schema Information
#
# Table name: registrations
#
#  id                :integer          not null, primary key
#  start_date        :datetime
#  end_date          :datetime
#  field_of_study_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Registration < ActiveRecord::Base

  belongs_to :field_of_study

  validates :start_date, :end_date, presence: true
  validates :field_of_study, presence: true
end
