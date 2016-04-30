# == Schema Information
#
# Table name: faculties
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

RSpec.describe Faculty, type: :model do
  it 'creates valid Faculty' do
    faculty = build(:faculty)
    expect(faculty).to be_valid
  end
end
