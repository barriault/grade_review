module RequestMacros
  def sign_in_as_user
    # I don't want to test authorization
    ability = Object.new
    ability.extend(CanCan::Ability)
    ApplicationController.any_instance.stub(:current_ability) { ability }
    ability.can :manage, :all

    @user ||= FactoryGirl.create :user
    post_via_redirect user_session_path, 'user[email]' => @user.email, 'user[password]' => @user.password
  end
end
