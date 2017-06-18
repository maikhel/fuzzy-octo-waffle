class CourseGroupJoiner
  attr_accessor :course_group

  def initialize(course_group)
    @course_group = course_group
  end

  def enroll(users)
    course_group.users << users if free_place? [*users].size
  rescue ActiveRecord::RecordNotUnique
    nil
  end

  def leave(users)
    CourseGroupsUser.delete_all(user_id: [*users].map(&:id))
  end

  def enrolled?(user)
    !CourseGroupsUser.find_by(course_group_id: course_group.id, user_id: user.id).nil?
  end

  def free_place?(num)
    course_group.max_limit - course_group.users.count >= num
  end
end
