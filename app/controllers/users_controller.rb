class UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy edit_basic_info update_basic_info)
  before_action :logged_in_user, only: %i(index show edit update destroy attend_employees edit_basic_info update_basic_info)
  # before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(index destroy attend_employees edit_basic_info update_basic_info)
  before_action :admin_or_correct_user, only: %i(show)
  before_action :set_one_month, only: %i(show)
  
  def index
    if params[:search] == ""
      redirect_to users_url
      flash[:danger] = "キーワードを入力してください。"
    else
      @users = User.paginate(page: params[:page]).search(params[:search]).order(id: "ASC")
      if params[:search].present?
        flash.now[:success] = "検索結果:#{@users.count}件"
      end
    end
  end
  
  def import
    User.import(params[:file])
    redirect_to users_url
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザーの新規登録に成功しました。"
      redirect_to @user
    else
      render :new
    end
  end
  
  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "#{@user.name}の情報を更新しました。"
      redirect_to users_url
    elsif @user.name.blank?
      flash[:danger] = "更新に失敗しました。<br>" + @user.errors.full_messages.join("<br>")
      redirect_to users_url
    else
      flash[:danger] = "#{@user.name}の情報更新に失敗しました。<br>" + @user.errors.full_messages.join("<br>")
      redirect_to users_url
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end
  
  def attend_employees
    @users = User.all
  end
  
  def edit_basic_info
  end
  
  def update_basic_info
    if @user.update_attributes(basic_info_params)
      flash[:success] = "#{@user.name}の基本情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :affiliation, :password, :password_confirmation)
    end
    
    def basic_info_params
      params.require(:user).permit(:affiliation, :basic_work_time, :work_time)
    end
end
