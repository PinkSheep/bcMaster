require 'Btce'

class MainController < ApplicationController
  def index
    @btce_info = Btce::Info.new
  end

  def success
  end

  def signup
  end
end
