class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user.blank?
      cannot :manage, Article
      can :read, Article
    else
      can :manage, Article, user: user
    end
  end
end
