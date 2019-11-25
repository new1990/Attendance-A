class OfficesController < ApplicationController
   before_action :logged_in_user, only: %i(index new create update destroy)
   before_action :admin_user, only: %i(index new create update destroy)
  
  def index
  end
  
  def new
    @office = Office.new
  end
  
  def create
  end
  
  def update
  end
  
  def destroy
  end
end
