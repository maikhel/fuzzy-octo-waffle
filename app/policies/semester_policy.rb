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
    true
  end

end