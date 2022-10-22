# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    type_of_user = user.user_type.user_type

    if type_of_user == 'super_admin' # super admin
      can :manage, :all
    elsif !user.enabled # if user not enabled show error page
      # render nothing for disabled user
    elsif type_of_user == 'admin' # admin
      can [:read, :update], AdminUser, id: user.id
      can :manage, Category
      can :manage, Item
      can :manage, Banner
      can :manage, Enrollement
      can :manage, UserAddress
      can :manage, UserInfo
      can :manage, User
      can :manage, CourseLevel
      can :manage, Testimonial
      # can :manage, Category, admin_user_id: user.id
      # can :read, Item, :category => { :admin_user_id => user.id }      
      # can [:create, :destroy, :update], Item
    else # user
      can :read, Category
      can :read, Item
      can :read, Banner
      can :read, User
    end
  end
end
