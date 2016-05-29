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

FactoryGirl.define do
  factory :registration do
    start_date Time.now
    end_date Time.now
    association :semester
  end
end
