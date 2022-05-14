class Ability
  include CanCan::Ability

  def initialize(user)
    cannot :manage, Article
    cannot :manage, Comment
    cannot :manage, Emote
    can :read, Article
    can :read, Comment

    return if user.blank?  # additional permissions for logged in users (they can read their own posts)

    can :manage, Article, user: user
    can :manage, Comment, user: user
    can :manage, Emote, user: user
  end
end
