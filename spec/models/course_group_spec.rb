# == Schema Information
#
# Table name: course_groups
#
#  id          :integer          not null, primary key
#  start_time  :time
#  end_time    :time
#  weekday     :integer
#  subject_id  :integer
#  lecturer_id :integer
#  max_limit   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  group_type  :string
#

require 'spec_helper'

RSpec.describe CourseGroup, type: :model do

  it 'creates valid CourseGroup' do
    group = create(:course_group)
    expect(group).to be_valid
  end

  describe 'CourseGroup::GROUP_TYPES' do
    it 'consists of lecture, class, conversatorium, laboratory' do
      expect(CourseGroup::GROUP_TYPES).to eq ['lecture', 'class', 'conversatorium', 'laboratory']
    end
  end

  describe 'validations' do
    it 'is invalid without start_time/end_time' do
      group1 = build(:course_group, start_time: nil)
      group2 = build(:course_group, end_time: nil)
      expect(group1).not_to be_valid
      expect(group2).not_to be_valid
    end

    it 'is invalid without weekday' do
      group = build(:course_group, weekday: nil)
      expect(group).not_to be_valid
    end

    it 'is valid when present: start_time, end_time, weekday, subject_id, lecturer_id' do
      group = create(:course_group)
      expect(group).to be_valid
    end
  end

end
