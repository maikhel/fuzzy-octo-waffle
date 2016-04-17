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
#

FactoryGirl.define do

  factory :subject do
    title { Faker::Lorem.word }
    short_description { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph(3) }
    literature { Faker::Lorem.paragraph(3) }
    requirements { Faker::Lorem.paragraph(3) }
    learning_outcomes { Faker::Lorem.paragraph(3) }
  end
end
