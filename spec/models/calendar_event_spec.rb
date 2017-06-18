# == Schema Information
#
# Table name: calendar_events
#
#  id              :integer          not null, primary key
#  start_date      :datetime
#  end_date        :datetime
#  course_group_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  time_period_num :integer
#

require 'spec_helper'

RSpec.describe CalendarEvent, type: :model do
  it 'creates valid CalendarEvent' do
    calendar_event = build(:calendar_event)
    expect(calendar_event).to be_valid
  end

  describe 'validations' do
    it 'is invalid without course group' do
      calendar_event = build(:calendar_event, course_group_id: nil)
      expect(calendar_event).not_to be_valid
    end

    it 'is invalid without start_date' do
      calendar_event = build(:calendar_event, start_date: nil)
      expect(calendar_event).not_to be_valid
    end

    it 'is invalid without time_period_num' do
      calendar_event = build(:calendar_event, time_period_num: nil)
      expect(calendar_event).not_to be_valid
    end

    it 'is invalid without end_date' do
      calendar_event = build(:calendar_event, end_date: nil)
      expect(calendar_event).not_to be_valid
    end
  end
end
