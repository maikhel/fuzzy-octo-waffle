# == Schema Information
#
# Table name: grades
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  course_group_id :integer
#  value           :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :grade do
    association :course_group
    association :user
    value 3
  end
end
