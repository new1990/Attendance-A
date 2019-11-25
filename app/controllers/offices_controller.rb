class OfficesController < ApplicationController
   before_action :logged_in_user, only: %i(index new create edit update destroy)
   before_action :admin_user, only: %i(index new create edit update destroy)
  
  def index
    @office = Office.new
  end
  
  def new
    # @office = Office.new
  end
  
  def create
    @office = Office.new(office_params)
    if @office.save
      flash[:success] = "拠点登録が完了しました。"
      redirect_to offices_url
    else
      render :index
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
    def office_params
      params.require(:office).permit(:office_number, :office_name, :attendance_type)
    end
end
