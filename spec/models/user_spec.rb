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

require 'spec_helper'

describe User do

  it 'creates valid user' do
    user = create(:user)
    expect(user).to be_valid
  end

  describe '.name' do
    it 'shows first name + last name' do
      user = create(:user, first_name: "Carl", last_name: "Kovalsky")
      expect(user.name).to eq "Carl Kovalsky"
    end
  end

  describe '.enrolled?' do
    let(:course_group) { create(:course_group) }
    let(:student) { create(:student) }
    let(:joiner) { CourseGroupJoiner.new(course_group) }

    it 'returns true if student enrolled to course' do
      joiner.enroll(student)
      expect(student.enrolled?(course_group)).to eq true
    end

    it 'returns false if student not enrolled to course' do
      expect(student.enrolled?(course_group)).to eq false
    end
  end

end
