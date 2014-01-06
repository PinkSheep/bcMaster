class MainController < ApplicationController
  before_action :authorize
  def index
    @btce_info = Btce::Info.new
  end

  protected
  def authorize
  		
  end
end
