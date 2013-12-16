class HelpController < ApplicationController
  def index
    @users = User.with_any_role(:admin)
  end
end
