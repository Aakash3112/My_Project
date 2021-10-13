class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user.role == "1"
  end

  def new?
    create?
  end

  def create?
    @user.has_role? == "1"
  end
end
