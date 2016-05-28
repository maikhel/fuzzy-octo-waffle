class CourseGroupPolicy < ApplicationPolicy

  def new?
    administrable?
  end

  def create?
    administrable?
  end

  def edit?
    administrable?
  end

  def update?
    administrable?
  end

  def destroy?
    administrable?
  end

  def update_grades?
    administrable? || user.id == record.lecturer_id rescue false
  end

  def show_grades?
    update_grades?
  end

  def registrate?
    administrable?
  end

  def deregistrate?
    administrable?
  end

end