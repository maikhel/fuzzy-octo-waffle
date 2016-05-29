require 'spec_helper'

describe SemesterJoiner do

  describe 'initialize' do
    it 'assigns semester' do
      semester = create(:semester)
      joiner = SemesterJoiner.new(semester)
      expect(joiner).to be_a SemesterJoiner
    end
  end

  describe 'join' do
    let(:semester) { create(:semester) }

    it 'adds semester to users semesters' do
      joiner = SemesterJoiner.new(semester)
      student = create(:student)
      joiner.join(student)
      expect(semester).to be_in student.semesters
    end

    it 'adds semester to many users' do
      joiner = SemesterJoiner.new(semester)
      students = create_list(:student, 3)
      joiner.join(students)
      expect(semester.users).to eq students
    end

    it 'doesnt add semester if user already has it' do
      joiner = SemesterJoiner.new(semester)
      student = create(:student)
      student.semesters << semester
      joiner.join(student)
      expect(SemestersUser.where(user_id: student.id, semester_id: semester.id).count).to eq 1
    end
  end

  describe 'leave' do
    let(:semester) { create(:semester) }

    it 'deletes semester from user.semesters' do
      student = create(:student)
      semester.users << student
      joiner = SemesterJoiner.new(semester).leave(student)
      expect(semester).not_to be_in student.semesters
    end

    it 'deletes semester for many users' do
      students = create_list(:student, 3)
      semester.users << students
      joiner = SemesterJoiner.new(semester).leave(students)
      expect(semester.users.count).to eq 0
    end

    it 'doesnt delete User or Semester' do
      student = create(:student)
      semester.users << student
      joiner = SemesterJoiner.new(semester)
      expect {
        joiner.leave(student)
      }.not_to change(Semester, :count)
    end

    it 'does not delete semester if user doesnt have it' do
      student = create(:student)
      joiner = SemesterJoiner.new(semester).leave(student)
      expect(semester).not_to be_in student.semesters
    end

  end

end