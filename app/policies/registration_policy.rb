class RegistrationPolicy < ApplicationPolicy

  def index?
    true
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

end