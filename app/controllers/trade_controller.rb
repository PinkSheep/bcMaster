class TradeController < ApplicationController
  before_action :authorize
  def index
  end


  protected
  def authorize
  	#falls keine Session vorhanden ist, wird man wieder auf die Mainseite weitergeleitet
  	# zu implementieren: notice message, welche dann auf der main-page angezeigt wird
  	if (@key_array =  session[:bcmaster]).nil?
  		redirect_to main_index_url
  	end
  end
end
