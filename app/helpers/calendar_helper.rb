module CalendarHelper
  def date_range(start_date=Date.today)
    start_date.to_date
    starting = start_date.beginning_of_week
    ending = starting.end_of_week

    (starting..ending).to_a
  end

  def sorted_by_hour(events)
    events = events.sort_by(&:time_period_num)

    scheduled = events.reject { |e| e.send(:time_period_num).nil? }
    scheduled.group_by { |e| e.send(:time_period_num) }
  end

  def sorted_by_date(events)
    events = events.sort_by(&:start_date)

    scheduled = events.reject { |e| e.send(:start_date).nil? }
    scheduled.group_by { |e| e.send(:start_date).to_date }
  end

  def url_for_next_view
    view_context.url_for(@params.merge(start_date: date_range.last + 1.day))
  end

  def url_for_previous_view
    view_context.url_for(@params.merge(start_date: date_range.first - 1.day))
  end
end
