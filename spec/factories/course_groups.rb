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

FactoryGirl.define do
  factory :course_group do
    start_time '2000-01-01 17:00:00 UTC'
    end_time '2000-01-01 20:00:00 UTC'
    weekday 2
    association :subject
    association :lecturer
    max_limit 100


    factory :course_group_with_students do

      after(:create) do |course_group, evaluator|
        students = create_list(:student, 5)
        course_group.users << students
      end
    end
  end
end
