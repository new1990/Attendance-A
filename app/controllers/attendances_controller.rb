class AttendancesController < ApplicationController
  before_action :set_user, only: %i(edit_one_month update_one_month one_month_apply update_one_month_apply)
  before_action :logged_in_user, only: %i(update edit_one_month update_one_month one_month_apply)
  before_action :admin_or_correct_user, only: %i(edit_one_month update_one_month)
  before_action :set_one_month, only: %i(edit_one_month)
  before_action :set_one_month_apply, only: %i(one_month_apply)
  
  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"
  
  def update
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    if @attendance.started_at.nil?
      if @attendance.update_attributes(started_at: Time.current.change(sec: 0))
        flash[:info] = "おはようございます！"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.finished_at.nil?
      if @attendance.update_attributes(finished_at: Time.current.change(sec: 0))
        flash[:info] = "お疲れ様でした。"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    end
    redirect_to @user
  end
  
  def edit_one_month
  end
  
  def update_one_month
    ActiveRecord::Base.transaction do
      if attendances_invalid?
        attendances_params.each do |id, item|
          attendance = Attendance.find(id)
          attendance.update_attributes!(item)
        end
        flash[:success] = "1ヶ月分の勤怠情報を更新しました。"
        redirect_to user_url(date: params[:date])
      else
        flash[:danger] = "不正な時間入力がありました、再入力してください。"
        redirect_to attendances_edit_one_month_user_url(date: params[:date])
      end
    end
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
    redirect_to attendances_edit_one_month_user_url(date: params[:date])
  end
  
  def one_month_apply
    @users = User.all
    @attendance = Attendance.find(params[:id])
  end
  
  def update_one_month_apply
    if @attendance.update_attributes(month_apply_params)
      flash[:success] = "#{@user.name}の申請を提出しました。"
      redirect_to user_url
    else
      flash[:danger] = "#{@user.name}の申請に失敗しました。"
      redirect_to user_url
    end
  end
  
  private
  
    def attendances_params
      params.require(:user).permit(attendances: [:started_at, :finished_at, :note])[:attendances]
    end
    
    def month_apply_params
      params.require(:user).permit(attendances: [:superior_id, :status, :month_apply, :month_approval, :month_check])[:attendances]
    end
end
