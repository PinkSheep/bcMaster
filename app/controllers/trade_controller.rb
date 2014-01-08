class TradeController < ApplicationController
  before_action :authorize
  def index
  end


  protected
  def authorize
  	#falls keine Session vorhanden ist, wird man wieder auf die Mainseite weitergeleitet
  	# zu implementieren: notice message, welche dann auf der main-page angezeigt wird
  	@key_array = Array.new
  	@key_array = session[:bcmaster]
  	if @key_array.nil?
  		redirect_to main_index_path
  	end
  end
end
