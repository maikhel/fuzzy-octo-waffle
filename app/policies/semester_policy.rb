class SemesterPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.semesters)
      end
    end
  end

  def index?
    administrable?
  end

  def show?
    administrable?
  end

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

  def add_students?
    administrable?
  end

  def remove_students?
    administrable?
  end
end
