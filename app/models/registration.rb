# == Schema Information
#
# Table name: registrations
#
#  id          :integer          not null, primary key
#  start_date  :datetime
#  end_date    :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  semester_id :integer
#

class Registration < ActiveRecord::Base

  belongs_to :semester

  validates :start_date, :end_date, presence: true
  validates :semester, presence: true
end
