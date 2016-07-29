class DashboardController < ApplicationController
  before_action :authenticate_user!
  layout 'application'

  def index
    @user = current_user
    groups_ids = @user.course_groups.pluck(:id)
    @semesters = @user.semesters
    start_date = params[:start_date] || Date.today
    starting = start_date.to_date.beginning_of_week
    ending = starting.end_of_week
    @calendar_events = CalendarEvent.where(course_group: groups_ids).where('start_date BETWEEN ? AND ?', starting.beginning_of_day, ending.end_of_day).group_by {|d| d.start_date.to_date}
  end

end