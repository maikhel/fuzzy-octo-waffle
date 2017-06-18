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
#  role                   :string           default("Student")
#

require 'spec_helper'

describe User do
  it 'creates valid user' do
    user = create(:user)
    expect(user).to be_valid
  end

  describe 'roles' do
    it 'creates student' do
      student = create(:student)
      expect(student.role).to eq 'Student'
    end

    it 'creates lecturer' do
      lecturer = create(:lecturer)
      expect(lecturer.role).to eq 'Lecturer'
    end

    it 'creates admin' do
      admin = create(:admin)
      expect(admin.role).to eq 'Admin'
    end
  end

  describe '.admin?' do
    it 'returns false' do
      user = create(:user)
      expect(user.admin?).to eq false
    end
  end

  describe '.student?' do
    it 'returns false' do
      user = create(:user)
      expect(user.student?).to eq false
    end
  end

  describe '.lecturer?' do
    it 'returns false' do
      user = create(:user)
      expect(user.lecturer?).to eq false
    end
  end

  describe '.name' do
    it 'shows first name + last name' do
      user = create(:user, first_name: 'Carl', last_name: 'Kovalsky')
      expect(user.name).to eq 'Carl Kovalsky'
    end
  end

  describe '.address' do
    it 'returns string with merget street, zip, city' do
      user = create(:user,
                    street: 'Konwaliowa 3',
                    postal_code: '33-222',
                    city: 'Warszawa',
                    country: 'PL')
      expect(user.address).to eq 'Konwaliowa 3, 33-222, Warszawa'
    end
  end

  describe '.average_grade' do
    it 'returns average from user grades' do
      student = create(:student)
      grade_avg = (3 * 4.0 + 2.0) / 4
      create_list(:grade, 3, user_id: student.id, value: 4.0)
      create(:grade, user_id: student.id, value: 2.0)
      expect(student.average_grade).to eq grade_avg
    end
  end

  describe '.subjects' do
    it 'returns all subjects that user is enrolled' do
      student = create(:student)
      student.course_groups << create_list(:course_group, 3)
      expect(student.subjects.count).to eq 3
    end
  end

  describe '.course_groups' do
    it 'returns all course_groups that user is enrolled' do
      student = create(:student)
      student.course_groups << create_list(:course_group, 3)
      expect(student.course_groups.count).to eq 3
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
