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
end
