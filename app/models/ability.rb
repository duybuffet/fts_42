class Ability
  include CanCan::Ability

  def initialize user
    return if user.nil?
    if user.admin?
      can :manage, :all
    else
      can [:update, :show], User, user.id
      can [:read, :update, :show], Exam, user_id: user.id
      can [:create, :update, :show], Exam
      can [:create], Question
      can [:update, :destroy, :index], Question, user_id: user.id
    end
  end
end
