# == Schema Information
#
# Table name: course_groups
#
#  id              :integer          not null, primary key
#  start_time      :time
#  end_time        :time
#  weekday         :integer
#  subject_id      :integer
#  lecturer_id     :integer
#  max_limit       :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  group_type      :string
#  time_period_num :integer
#

require 'spec_helper'

RSpec.describe CourseGroup, type: :model do

  it 'creates valid CourseGroup' do
    group = create(:course_group)
    expect(group).to be_valid
  end

  it 'creates CourseGroup with students' do
    group = create(:course_group_with_students)
    expect(group.users.count).to eq 5
  end

  describe 'CourseGroup::GROUP_TYPES' do
    it 'consists of lecture, class, conversatorium, laboratory' do
      expect(CourseGroup::GROUP_TYPES).to eq ['lecture', 'class', 'conversatorium', 'laboratory']
    end
  end

  describe 'validations' do
    it 'is invalid without time_period_num' do
      group = build(:course_group, time_period_num: nil)
      expect(group).not_to be_valid
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

  describe '#from_semester' do
    it 'returns only course_groups from given semester' do
      create_list(:course_group, 3)
      semester = CourseGroup.last.subject.semester
      expect(CourseGroup.from_semester(semester.id).count).to eq 1
    end
  end

end
