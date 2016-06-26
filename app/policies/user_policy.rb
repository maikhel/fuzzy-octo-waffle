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

  def update?
    administrable?
  end

  def destroy?
    administrable?
  end

end