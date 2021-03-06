class CalendarEventsCreator
  attr_accessor :course_group

  def initialize(course_group)
    @course_group = course_group
  end

  def run
    start_date = course_group.subject.semester.start_date.to_datetime
    end_date = course_group.subject.semester.end_date.to_datetime

    days = (start_date..end_date).to_a.select { |k| k.wday == course_group.weekday }
    course_group.calendar_events.destroy_all
    create_calendar_events days
  end

  def create_calendar_events(days)
    days.each do |day|
      day_start = day.change(hour: course_group.start_time.hour - 1, min: course_group.start_time.min)
      day_end = day.change(hour: course_group.end_time.hour - 1, min: course_group.end_time.min)

      CalendarEvent.create(
        course_group: course_group,
        start_date: day_start,
        end_date: day_end,
        time_period_num: course_group.time_period_num
      )
    end
  end
end
