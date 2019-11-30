class RequestsController < ApplicationController
  
  def new
    @request = Reqest.new
  end
  
  def create
    redirect_to current_user
  end
  
  def update
  end
end
