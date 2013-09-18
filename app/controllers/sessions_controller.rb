class SessionsController < ApplicationController

  def new
    redirect_to auth_path('cas')
  end


  def create
    auth = request.env["omniauth.auth"]
    
    if user = User.where(:provider => auth['provider'], :uid => auth['uid'].to_s).first
      # Reset the session after successful login, per
      # 2.8 Session Fixation – Countermeasures:
      # http://guides.rubyonrails.org/security.html#session-fixation-countermeasures
      reset_session
      session[:user_id] = user.id
      # user.add_role :admin if User.count == 1 # make the first user an admin
      redirect_to root_url, :notice => "Logged in as #{user.name}."
    else
      redirect_to root_url, :alert => "You are not authorized to use this system."
    end

  end

  def destroy
    reset_session
    redirect_to root_url, :alert => 'You have logged out of the TAMUG Grade Review portal. IMPORTANT: For security reasons please close your browser.'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
