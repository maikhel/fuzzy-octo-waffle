class ModalsController < ApplicationController
  def select_users
    @course_group = CourseGroup.find modal_params[:course_group_id]
    @students = @course_group.subject.semester.students
    render partial: 'select_users_modal', layout: false
  end

  def update_grades
    @course_group = CourseGroup.find modal_params[:course_group_id]
    @students = @course_group.enrolled_students
    render partial: 'update_grades_modal', layout: false
  end

  def add_students
    @semester = Semester.find modal_params[:semester_id]
    @students = Student.where.not(id: @semester.students.pluck(:id))
    render partial: 'add_students_modal', layout: false
  end

  private

  def modal_params
    params.permit(:course_group_id, :semester_id)
  end
end
