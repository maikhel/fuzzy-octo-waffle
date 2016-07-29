class UserPolicy < ApplicationPolicy

  def new?
    administrable?
  end

  def create?
    administrable?
  end

  def edit?
    administrable?
  end

  def index?
    administrable?
  end

  def update?
    administrable? || record.id == current_user.id rescue false
  end

  def destroy?
    administrable?
  end

end