
require 'spec_helper'

describe CourseGroupJoiner do


  describe 'initialize' do
    let(:student) { create(:student) }
    let(:course_group) { create(:course_group) }

    it 'creates CourseGroupJoiner' do
      joiner = CourseGroupJoiner.new(student.id, course_group.id)
      expect(joiner).to be_a CourseGroupJoiner
    end

    it 'creates new StudentCourseGroup entity' do
      expect {
        CourseGroupJoiner.new(student.id, course_group.id)
      }.to change{CourseGroupsUser.count}.by 1
    end

    it 'creates associations' do
      CourseGroupJoiner.new(student.id, course_group.id)
      student.reload
      course_group.reload
      expect(student.course_groups).to eq [course_group]
      expect(course_group.users).to eq [student]
    end

    it 'doesnt duplicate records' do
      CourseGroupJoiner.new(student.id, course_group.id)
      expect{
        CourseGroupJoiner.new(student.id, course_group.id)
      }.not_to change{CourseGroupsUser.count}
    end

  end

end