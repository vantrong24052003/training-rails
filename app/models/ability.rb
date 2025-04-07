# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post

    if user.has_role? :admin
      can :manage, Post
    elsif user.has_role? :user
      can :create, Post
    end
  end
end
