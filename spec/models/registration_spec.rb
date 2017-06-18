# == Schema Information
#
# Table name: registrations
#
#  id          :integer          not null, primary key
#  start_date  :datetime
#  end_date    :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  semester_id :integer
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

    it 'is invalid without semester' do
      expect(build(:registration, semester_id: nil)).not_to be_valid
    end
  end
end
