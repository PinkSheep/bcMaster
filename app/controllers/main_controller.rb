class MainController < ApplicationController
  def index
    @btce_info = Btce::Info.new
  end
end
