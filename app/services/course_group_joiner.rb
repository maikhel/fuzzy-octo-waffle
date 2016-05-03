class CourseGroupJoiner

  def initialize(user_id, course_group_id)
    begin
      CourseGroupsUser.create(
        user_id: user_id,
        course_group_id: course_group_id
      )
    rescue ActiveRecord::RecordNotUnique
      nil
    end
  end

end