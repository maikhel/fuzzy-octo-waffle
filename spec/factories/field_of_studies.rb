# == Schema Information
#
# Table name: field_of_studies
#
#  id         :integer          not null, primary key
#  title      :string           default("")
#  mode       :string           default("")
#  degree     :string           default("")
#  dean_id    :integer
#  faculty_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :field_of_study do
    title { Faker::Lorem.word }
    mode FieldOfStudy::MODE_TYPES.first
    degree FieldOfStudy::DEGREE_TYPES.first
    association :dean
    association :faculty
  end
end
