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

require 'spec_helper'

RSpec.describe Grade, type: :model do
  it 'creates valid grade' do
    grade = build(:grade)
    expect(grade).to be_valid
  end

  describe 'validations' do
    it 'is invalid with value not in [2,3,3.5,4,4.5,5]' do
      grade = build(:grade, value: 2.5)
      expect(grade).not_to be_valid
    end

    it 'is invalid without user' do
      grade = build(:grade, user_id: nil)
      expect(grade).not_to be_valid
    end

    it 'is invalid without course_group' do
      grade = build(:grade, course_group_id: nil)
      expect(grade).not_to be_valid
    end
  end
end
