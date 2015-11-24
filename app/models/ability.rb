class Ability
  include CanCan::Ability

  def initialize user
    if user.admin?
      can :manage, :all
    else
      can [:update, :show], User, user.id
    end
  end
end
