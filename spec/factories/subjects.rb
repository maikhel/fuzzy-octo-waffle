# == Schema Information
#
# Table name: subjects
#
#  id                :integer          not null, primary key
#  title             :string
#  coordinator_id    :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  description       :text
#  short_description :text
#  literature        :text
#  requirements      :text
#  learning_outcomes :text
#  semester_id       :integer
#

FactoryGirl.define do
  factory :subject do
    title { Faker::Lorem.word }
    short_description { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(3) }
    literature { Faker::Lorem.paragraph(3) }
    requirements { Faker::Lorem.paragraph(3) }
    learning_outcomes { Faker::Lorem.paragraph(3) }
    association :semester
  end

  trait :with_groups do
    transient do
      groups_count 3
    end

    after(:create) do |subject, evaluator|
      create_list(:course_group, evaluator.groups_count, subject: subject)
    end
  end
end
