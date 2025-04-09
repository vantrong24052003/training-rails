# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post

    if user.has_role? :admin
      can :manage, all
    elsif user.has_role? :user
      can [ :create, :edit, :update, :destroy ], Post, user_id: user.id
    end
  end
end
