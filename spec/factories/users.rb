# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  birth_date             :date
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  index_num              :string
#  street                 :string
#  postal_code            :string
#  city                   :string
#  country                :string
#  bank_account           :string
#

FactoryGirl.define do

  factory :user, aliases: [:lecturer, :student, :dean] do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password Faker::Internet.password(8)
    index_num { Faker::Number.number(6) }

    country Faker::Address.country_code
  end

end
