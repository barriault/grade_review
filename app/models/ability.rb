class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    alias_action :read, :update, :show_search, :approve, :to => :manage_student
    alias_action :read, :update, :show_search, :grant, :deny, :undo, :to => :recommend_appeal
    alias_action :read, :update, :show_search, :grant, :deny, :undo, :to => :manage_appeal
    alias_action :read, :update, :show_search, :to => :manage_address
    
    if user.has_role? :admin
      can :manage, :all
    end
    
    if user.has_role?(:sail) && Term.current.is_summer?
      can :manage_student, Student
      can :recommend_appeal, AppealRecommendation
      can :manage_address, Address
    end
    
    if user.has_role? :super_user
      # can [:read, :show_search], Student
      can :manage_student, Student
      can :manage_appeal, Appeal
      can :manage_address, Address
    end
    
    if user.has_role? :assistant
      can [:read, :show_search], Student
      can :manage_address, Address
    end
    
    if user.has_role? :marb
      # can [:read, :show_search], Student
      can :manage_student, Student, :major => ['MARB', 'MARF', 'BS-MARB', 'BS-MARB-LIO', 'BS-MARF']
      can :recommend_appeal, AppealRecommendation, :major => ['MARB', 'MARF', 'BS-MARB', 'BS-MARB-LIO', 'BS-MARF']
      can :manage_address, Address, :major => ['MARB', 'MARF', 'BS-MARB', 'BS-MARB-LIO', 'BS-MARF']
    end
    
    if user.has_role? :mare
      # can [:read, :show_search], Student
      can :manage_student, Student, :major => ['MARR', 'MARE', 'BS-MARR', 'BS-MARR-LIO']
      can :recommend_appeal, AppealRecommendation, :major => ['MARR', 'MARE', 'BS-MARR', 'BS-MARR-LIO']
      can :manage_address, Address, :major => ['MARR', 'MARE', 'BS-MARR', 'BS-MARR-LIO']
    end
    
    if user.has_role? :mars
      # can [:read, :show_search], Student
      can :manage_student, Student, :major => ['MARS', 'OCRE', 'USGA', 'BS-MARS', 'BS-MARS-LIO', 'BS-OCRE', 'BS-OCRE-GMR', 'BS-USGA-OOH']
      can :recommend_appeal, AppealRecommendation, :major => ['MARS', 'OCRE', 'USGA', 'BS-MARS-LIO', 'BS-OCRE', 'BS-OCRE-GMR', 'BS-USGA-OOH']
      can :manage_address, Address, :major => ['MARS', 'OCRE', 'USGA', 'BS-MARS-LIO', 'BS-OCRE', 'BS-OCRE-GMR', 'BS-USGA-OOH']
    end
    
    if user.has_role? :gacd
      # can [:read, :show_search], Student
      can :manage_student, Student, :major => ['GACD', 'MAST', 'BAC-GACD', 'BA-MAST', 'BS-USGA-MPC', 'BS-USGA-TCC', 'BS-USGA-MLP']
      can :recommend_appeal, AppealRecommendation, :major => ['GACD', 'MAST', 'BAC-GACD', 'BA-MAST', 'BS-USGA-MPC', 'BS-USGA-TCC', 'BS-USGA-MLP']
      can :manage_address, Address, :major => ['GACD', 'MAST', 'BAC-GACD', 'BA-MAST', 'BS-USGA-MPC', 'BS-USGA-TCC', 'BS-USGA-MLP']
    end
    
    if user.has_role? :ocse
      # can [:read, :show_search], Student
      can :manage_student, Student, :major => ['OCSE', 'OCSL', 'BS-OCSE', 'BS-OCSL']
      can :recommend_appeal, AppealRecommendation, :major => ['OCSE', 'OCSL', 'BS-OCSE', 'BS-OCSL']
      can :manage_address, Address, :major => ['OCSE', 'OCSL', 'BS-OCSE', 'BS-OCSL']
    end
    
    if user.has_role? :mara
      # can [:read, :show_search], Student
      can :manage_student, Student, :major => ['MARA','BS-MARA', 'BS-MARA-GAD']
      can :recommend_appeal, AppealRecommendation, :major => ['MARA','BS-MARA', 'BS-MARA-GAD']
      can :manage_address, Address, :major => ['MARA','BS-MARA', 'BS-MARA-GAD']
    end
    
    if user.has_role? :mart
      # can [:read, :show_search], Student
      can :manage_student, Student, :major => ['MART', 'BS-MART']
      can :recommend_appeal, AppealRecommendation, :major => ['MART', 'BS-MART']
      can :manage_address, Address, :major => ['MART', 'BS-MART']
    end
    
  end
end
