# == Schema Information
#
# Table name: field_of_studies
#
#  id         :integer          not null, primary key
#  title      :string           default("")
#  mode       :string           default("")
#  degree     :string           default("")
#  dean_id    :integer
#  faculty_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

RSpec.describe FieldOfStudy, type: :model do
  it 'creates valid FieldOfStudy' do
    field = build(:field_of_study)
    expect(field).to be_valid
  end

  it 'creates FieldOfStudy with associated objects' do
    field = create(:field_of_study)
    expect(field.dean).to be_a User
    expect(field.faculty).to be_a Faculty
  end

  describe 'validations' do
    it 'is invalid without title, mode, degree, dean or faculty' do
      expect(build(:field_of_study, title: nil)).not_to be_valid
      expect(build(:field_of_study, mode: nil)).not_to be_valid
      expect(build(:field_of_study, degree: nil)).not_to be_valid
      expect(build(:field_of_study, faculty_id: nil)).not_to be_valid
    end

    it 'is invalid if degree isnt in DEGREE_TYPES' do
      expect(build(:field_of_study, degree: 'lol')).not_to be_valid
    end

    it 'is invalid if mode isnt in MODE_TYPES' do
      expect(build(:field_of_study, mode: 'lol')).not_to be_valid
    end
  end
end
