module ControllerMacros
  def login_admin
    before(:each) do
      # I don't want to test authorization in the controllers
      ability = Object.new
      ability.extend(CanCan::Ability)
      controller.stub(:current_ability) { ability }
      ability.can :manage, :all

      @request.env["devise.mapping"] = Devise.mappings[:admin_user]
      @signed_in_user = FactoryGirl.create(:admin_user)
      # user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in :user, @signed_in_user # sign_in(scope, resource)
    end
  end

  def login_user
    before(:each) do
      # I don't want to test authorization in the controllers
      ability = Object.new
      ability.extend(CanCan::Ability)
      controller.stub(:current_ability) { ability }
      ability.can :manage, :all

      @request.env["devise.mapping"] = Devise.mappings[:user]
      @signed_in_user = FactoryGirl.create(:user)
      # user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in @signed_in_user
    end
  end
end