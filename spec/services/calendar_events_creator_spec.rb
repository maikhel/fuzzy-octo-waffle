
require 'spec_helper'

describe CalendarEventsCreator do

  describe '.initialize' do
    it 'assigns @course_group' do
      course_group = create(:course_group)
      creator = CalendarEventsCreator.new(course_group)
      expect(creator).to be_a CalendarEventsCreator
    end
  end

  describe '.run' do
    let(:course_group) { create(:course_group) }
    let(:creator) { CalendarEventsCreator.new(course_group) }

    it 'creates CalendarEvents' do
      expect{ creator.run }.to change(CalendarEvent, :count)
    end

    it 'creates CalendarEvents for each week in semester' do
      creator.run
      start_date = course_group.subject.semester.start_date.to_datetime
      end_date = course_group.subject.semester.end_date.to_datetime
      day = course_group.weekday
      result = (start_date..end_date).to_a.select {|k| k.wday == day }
      expect(CalendarEvent.count).to eq result.size
    end

    it 'creates CalendarEvents with hours form course_group' do
      creator.run
      start_hours = course_group.start_time.strftime('%H:%M')
      end_hours = course_group.end_time.strftime('%H:%M')
      # expect(CalendarEvent.last.start_date.strftime('%H:%M')).to eq start_hours
      expect(CalendarEvent.last.end_date.strftime('%H:%M')).to eq end_hours
    end


  end

end