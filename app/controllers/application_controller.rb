class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize
  
  protected
  def authorize
  	#falls keine Session vorhanden ist, wird man wieder auf die Mainseite weitergeleitet
    if (@key_array = session[:bcmaster]).nil? && !self.is_a?(PublicController)
      flash[:notice] = "sign in first"
      redirect_to main_index_url
    end
  end
end
