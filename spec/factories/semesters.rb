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

FactoryGirl.define do
  factory :semester do
    association :field_of_study
    start_date { Date.today - 3.months }
    end_date { Date.today + 3.months }

    factory :semester_with_subjects do
      after(:create) do |semester|
        create_list(:subject, 3, semester: semester)
      end
    end
  end
end
