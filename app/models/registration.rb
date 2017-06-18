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

  def title
    semester.to_s + " -- #{I18n.l(start_date, format: :short)}- #{I18n.l(end_date, format: :short)}"
  end
end
