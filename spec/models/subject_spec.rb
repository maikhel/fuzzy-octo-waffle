# == Schema Information
#
# Table name: subjects
#
#  id                :integer          not null, primary key
#  title             :string
#  coordinator_id    :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  description       :text
#  short_description :text
#  literature        :text
#  requirements      :text
#  learning_outcomes :text
#

require 'spec_helper'

RSpec.describe Subject, type: :model do

  it 'creates valid subject' do
    subject = create(:subject)
    expect(subject).to be_valid
  end

  it 'creates valid subject with course groups' do
    subject = create(:subject, :with_groups)
    expect(subject).to be_valid
    expect(subject.course_groups.count).to eq 3
  end


  describe 'validations' do
    it 'is invalid without title' do
      subject = build(:subject, title: nil)
      expect(subject).not_to be_valid
    end

    it 'is invalid without short description' do
      subject = build(:subject, short_description: nil)
      expect(subject).not_to be_valid
    end
  end

end
