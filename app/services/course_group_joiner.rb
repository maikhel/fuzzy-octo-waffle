class CourseGroupJoiner < Struct.new(:course_group)

  def add(users)
    begin
      course_group.users << users if free_place? [*users].size
    rescue ActiveRecord::RecordNotUnique
      nil
    end
  end

  def free_place?(num)
    course_group.max_limit - course_group.users.count >= num
  end

end