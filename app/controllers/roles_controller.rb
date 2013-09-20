class RolesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
  end

  def show
  end
  
  def update
    if @role.update_attributes(params[:role])
      redirect_to roles_path, :notice => "Role updated."
    else
      redirect_to roles_path, :alert => "Unable to update role."
    end
  end
    
  def destroy
    @role.destroy
    redirect_to roles_path, :notice => "Role deleted."
  end
  
  def edit
  end
  
  def new
    @role = Role.new
  end
  
  def create
    @role = Role.new(params[:role])
    if @role.save
      redirect_to roles_path, notice: 'Role was successfully created.'
    else
      render action: "new"
    end
  end
  
end