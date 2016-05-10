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

FactoryGirl.define do
  factory :registration do
    start_date Time.now
    end_date Time.now
    association :field_of_study
  end
end
