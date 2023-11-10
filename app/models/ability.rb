# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Abilities for all users
    can :read, :all

    # Abilities for authenticated users
    if user.present?
      can :manage, Post, author_id: user.id
      can :create, Comment
      can :manage, Comment, user_id: user.id

      # Abilities for admin users
      can :manage, :all if user.admin?
    end
  end
end
