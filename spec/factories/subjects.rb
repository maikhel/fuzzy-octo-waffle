# == Schema Information
#
# Table name: subjects
#
#  id             :integer          not null, primary key
#  title          :string
#  coordinator_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :subject do
    title { Faker::Lorem.word }
  end
end
