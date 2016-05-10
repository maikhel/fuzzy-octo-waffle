# == Schema Information
#
# Table name: registrations
#
#  id                :integer          not null, primary key
#  start_date        :datetime
#  end_date          :datetime
#  field_of_study_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

RSpec.describe Registration, type: :model do

  it 'creates valid Registration' do
    registration = build(:registration)
    expect(registration).to be_valid
  end

  describe 'validations' do
    it 'is invalid without start or end date' do
      expect(build(:registration, start_date: nil)).not_to be_valid
      expect(build(:registration, end_date: nil)).not_to be_valid
    end

    it 'is invalid without field of study' do
      expect(build(:registration, field_of_study: nil)).not_to be_valid
    end
  end
end
