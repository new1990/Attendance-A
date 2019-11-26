class OfficesController < ApplicationController
   before_action :logged_in_user, only: %i(index create edit update destroy)
   before_action :admin_user, only: %i(index create edit update destroy)
  
  def index
    @office = Office.new
    @offices = Office.all
  end
  
  def create
    @office = Office.new(office_params)
    if @office.save
      flash[:success] = "拠点登録が完了しました。"
      redirect_to offices_url
    else
      flash[:danger] = "拠点登録に失敗しました、入力エラーが#{@office.errors.count}件あります。<br>" + @office.errors.full_messages.join("<br>")
      redirect_to offices_url
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
