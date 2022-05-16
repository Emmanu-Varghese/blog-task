class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user.blank?
      cannot :manage, Article
      cannot :manage, Comment
      cannot :manage, Emote
      can :read, Article
      can :read, Comment
    else
      can :manage, Article, user: user
      can :manage, Comment, user: user
      can :manage, Emote, user: user
    end
  end
end
