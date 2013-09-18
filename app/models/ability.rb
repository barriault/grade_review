class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    
    user ||= User.new # guest user (not logged in)
    
    alias_action :read, :update, :show_search, :approve, :change, :remove, :to => :manage_student
    
    if user.has_role? :admin
      can :manage, :all
    end
    
    if user.has_role? :super_user
      can :manage_student, Student
    end
    
    if user.has_role? :marb
      can :manage_student, Student, :major => ['MARB', 'MARF']
    end
    
    if user.has_role? :marr
      can :manage_student, Student, :major => ['MARR', 'MARE']
    end
    
    if user.has_role? :mars
      can :manage_student, Student, :major => ['MARS', 'OCRE', 'USGA']
    end
    
    if user.has_role? :gacd
      can :manage_student, Student, :major => ['GACD', 'MAST',]
    end
    
    if user.has_role? :mase
      can :manage_student, Student, :major => ['MASE', 'MASL']
    end
    
    if user.has_role? :mara
      can :manage_student, Student, :major => 'MARA'
    end
    
    if user.has_role? :mart
      can :manage_student, Student, :major => 'MART'
    end
    
  end
end
