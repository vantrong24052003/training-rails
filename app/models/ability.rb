# frozen_string_literal: true

class Ability
  include CanCan::Ability
  def initialize(user)
    can :read, Post, public: true
    if user.has_role? :admin
      can :manage, :all
    else
      can :read, :all
    end
  end
end
