class CourseGroupJoiner < Struct.new(:course_group)

  def enroll(users)
    begin
      course_group.users << users if free_place? [*users].size
    rescue ActiveRecord::RecordNotUnique
      nil
    end
  end

  def leave(users)
    CourseGroupsUser.delete_all(user_id: [*users].map(&:id))
  end

  def free_place?(num)
    course_group.max_limit - course_group.users.count >= num
  end

end