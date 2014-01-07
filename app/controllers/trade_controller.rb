class TradeController < ApplicationController
  before_action :authorize
  def index
  end


  protected
  def authorize
  	@key_array = Array.new
  	@key_array = session[:bcmaster]
  	if @key_array.nil?
  		redirect_to main_index_path
  	end
  end
end
