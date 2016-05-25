class GradesController < ApplicationController


  def create
    course_group = CourseGroup.find params[:course_group_id]
    # grade = Grade.new(grade_params.merge(course_group: course_group))
    # grade.save
    # params[:grades].each do |key, value|
    #   grade = Grade.new(value.merge(course_group: course_group))
    #   grade.save
    # end
    # binding.pry
    redirect_to subject_course_group_path(subject_id: course_group.subject.id, id: course_group.id)
  end

  private

    def grade_params
      params.require(:grade).permit(:value, :user_id, :course_group)
    end

end
