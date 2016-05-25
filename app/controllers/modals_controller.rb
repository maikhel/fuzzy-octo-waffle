class ModalsController < ApplicationController

  def select_users
    @course_group = CourseGroup.find modal_params[:course_group_id]
    @students = User.all
    render partial: 'select_users_modal', layout: false
  end

  def update_grades
    @course_group = CourseGroup.find modal_params[:course_group_id]
    @students = @course_group.users
    render partial: 'update_grades_modal', layout: false
  end


  private

    def modal_params
      params.permit(:course_group_id)
    end

end