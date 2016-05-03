
require 'spec_helper'

describe CourseGroupJoiner do

  describe 'initialize' do
    let(:course_group) { create(:course_group) }

    it 'creates CourseGroupJoiner' do
      joiner = CourseGroupJoiner.new(course_group)
      expect(joiner).to be_a CourseGroupJoiner
    end
  end

  describe '.add' do
    let(:student) { create(:student) }
    let(:course_group) { create(:course_group) }
    let(:joiner) { CourseGroupJoiner.new(course_group) }

    it 'creates new StudentCourseGroup entity' do
      expect {
        joiner.add(student)
      }.to change{CourseGroupsUser.count}.by 1
    end

    it 'creates associations' do
      joiner.add(student)
      expect(student.course_groups).to eq [course_group]
      expect(course_group.users).to eq [student]
    end

    it 'doesnt duplicate records' do
      joiner.add(student)
      expect{
        joiner.add(student)
      }.not_to change{CourseGroupsUser.count}
    end

    it 'does not add record if max limit reached' do
      course_group.update(max_limit: 2)
      joiner = CourseGroupJoiner.new(course_group)
      student1 = create(:student)
      student2 = create(:student)
      joiner.add(student1)
      joiner.add(student2)
      joiner.add(student)
      expect(course_group.users.count).to eq 2
    end

    it 'adds array of students if is place for all of them' do
      course_group.update(max_limit: 5)
      joiner = CourseGroupJoiner.new(course_group)
      students = create_list(:student, 4)
      joiner.add(students)
      expect(course_group.users).to eq students
      expect(course_group.users.count).to eq 4
    end

  end

  describe '.free_place?' do
    let(:student) { create(:student) }
    let(:course_group) { create(:course_group, max_limit: 2) }
    let(:joiner) { CourseGroupJoiner.new(course_group) }

    it 'returns true if max limit not reached' do
      joiner.add(student)
      expect(joiner.free_place?(1)).to eq true
    end

    it 'returns false is max limit reached' do
      joiner.add(student)
      joiner.add(create(:student))
      expect(joiner.free_place?(1)).to eq false
    end
  end

end