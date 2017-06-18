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

  describe '.to_s' do
    it 'returns string with dates and field of study title' do
      semester = create(:semester,
                        start_date: Date.parse('01-10-2016'),
                        end_date: Date.parse('15-03-2017'))
      expect(semester.to_s).to eq "#{semester.field_of_study.title} 2016/2017"
    end
  end
end
