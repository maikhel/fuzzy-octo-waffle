# == Schema Information
#
# Table name: calendar_events
#
#  id              :integer          not null, primary key
#  start_date      :datetime
#  end_date        :datetime
#  course_group_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :calendar_event do
    start_date "2016-05-28 13:15:00"
    end_date "2016-05-28 14:45:00"
    association :course_group
  end
end
