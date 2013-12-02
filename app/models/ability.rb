class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    alias_action :read, :update, :show_search, :approve, :to => :manage_student
    alias_action :read, :update, :show_search, :grant, :deny, :to => :recommend_appeal
    alias_action :read, :update, :show_search, :grant, :deny, :to => :manage_appeal
    alias_action :read, :update, :show_search, :to => :manage_address
    
    if user.has_role? :admin
      can :manage, :all
    end
    
    if user.has_role? :super_user
      can :manage_student, Student
      can :manage_appeal, Appeal
      can :manage_address, Address
    end
    
    if user.has_role? :assistant
      can [:read, :show_search], Student
      can :manage_address, Address
    end
    
    if user.has_role? :marb
      can :manage_student, Student, :major => ['MARB', 'MARF']
      can :recommend_appeal, AppealRecommendation, :major => ['MARB', 'MARF']
      an :manage_address, Address, :major => ['MARB', 'MARF']
    end
    
    if user.has_role? :mare
      can :manage_student, Student, :major => ['MARR', 'MARE']
      can :recommend_appeal, AppealRecommendation, :major => ['MARR', 'MARE']
      an :manage_address, Address, :major => ['MARR', 'MARE']
    end
    
    if user.has_role? :mars
      can :manage_student, Student, :major => ['MARS', 'OCRE', 'USGA']
      can :recommend_appeal, AppealRecommendation, :major => ['MARS', 'OCRE', 'USGA']
      an :manage_address, Address, :major => ['MARS', 'OCRE', 'USGA']
    end
    
    if user.has_role? :gacd
      can :manage_student, Student, :major => ['GACD', 'MAST']
      can :recommend_appeal, AppealRecommendation, :major => ['GACD', 'MAST']
      an :manage_address, Address, :major => ['GACD', 'MAST']
    end
    
    if user.has_role? :mase
      can :manage_student, Student, :major => ['MASE', 'MASL']
      can :recommend_appeal, AppealRecommendation, :major => ['MASE', 'MASL']
      an :manage_address, Address, :major => ['MASE', 'MASL']
    end
    
    if user.has_role? :mara
      can :manage_student, Student, :major => 'MARA'
      can :recommend_appeal, AppealRecommendation, :major => 'MARA'
      an :manage_address, Address, :major => 'MARA'
    end
    
    if user.has_role? :mart
      can :manage_student, Student, :major => 'MART'
      can :recommend_appeal, AppealRecommendation, :major => 'MART'
      an :manage_address, Address, :major => 'MART'
    end
    
  end
end
