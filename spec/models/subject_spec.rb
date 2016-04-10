# == Schema Information
#
# Table name: subjects
#
#  id             :integer          not null, primary key
#  title          :string
#  coordinator_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'spec_helper'

RSpec.describe Subject, type: :model do

  it 'creates valid subject' do
    subject = create(:subject)
    expect(subject).to be_valid
  end

  describe 'validations' do
    it 'is invalid without title' do
      subject = build(:subject, title: nil)
      expect(subject).not_to be_valid
    end
  end

end
