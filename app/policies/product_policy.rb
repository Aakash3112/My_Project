class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def edit?
    true
  end

  def update?
    # @user.role == "1" || @product.user == current_user
    true
  end

end
