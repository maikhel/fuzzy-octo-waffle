# == Schema Information
#
# Table name: semesters
#
#  id                :integer          not null, primary key
#  field_of_study_id :integer
#  start_date        :datetime
#  end_date          :datetime
#  period_type       :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

RSpec.describe Semester, type: :model do

  it 'creates valid Semester' do
    semester = build(:semester)
    expect(semester).to be_valid
  end

  it 'creates semester with subjects' do
    semester = create(:semester_with_subjects)
    expect(semester.subjects.count).to eq 3
  end

  describe 'validations' do
    it 'is invalid without field_of_study_id' do
      semester = build(:semester, field_of_study_id: nil)
      expect(semester).not_to be_valid
    end

    it 'is invalid without start_date' do
      semester = build(:semester, start_date: nil)
      expect(semester).not_to be_valid
    end

    it 'is invalid without end_date' do
      semester = build(:semester, end_date: nil)
      expect(semester).not_to be_valid
    end
  end
end
