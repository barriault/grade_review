class TermsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
  end

  def show
  end
  
  def update
    if @term.update_attributes(params[:term])
      redirect_to terms_path, :notice => "Term updated."
    else
      redirect_to terms_path, :alert => "Unable to update term."
    end
  end
    
  def destroy
    unless @term.active?
      @term.destroy
      redirect_to terms_path, :notice => "Term deleted."
    else
      redirect_to terms_path, :notice => "Can't delete active term."
    end
  end
  
  def edit
  end
  
  def new
    @term = Term.new
  end
  
  def create
    @term = Term.new(params[:term])
    if @term.save
      redirect_to terms_path, notice: 'Term was successfully created.'
    else
      render action: "new"
    end
  end
  
end
