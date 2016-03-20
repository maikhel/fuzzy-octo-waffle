

FactoryGirl.define do

  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email Faker::Internet.email
    password Faker::Internet.password(8)
    index_num Faker::Number.number(6)

    country Faker::Address.country_code
  end

end