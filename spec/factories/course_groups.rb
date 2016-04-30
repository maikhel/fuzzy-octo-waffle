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
    start_time { Faker::Time.between(4.days.ago, Date.today, :all).strftime("%H:%M") }
    end_time { ((Faker::Time.between(4.days.ago, Date.today, :all)) + 1.5.hours).strftime("%H:%M") }
    weekday 2
    association :subject
    association :lecturer
    max_limit 100
  end
end
