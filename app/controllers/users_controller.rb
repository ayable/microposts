class UsersController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :updatea]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end

  def update

    if @user.update(user_params)
      # 保存に成功した場合はユーザへリダイレクト
      flash[:success] = "Success to edit profile!"
      redirect_to @user
    else
      # 保存に失敗した場合は編集画面へ戻す
      flash.now[:alert] = "メッセージの保存に失敗しました。"
      render 'edit'
    end
  end
  
  def followings
  end

  def followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,
                                 :age, :address)
  end
  def set_profile
    @user = User.find(params[:id])
  end
  
  def correct_user
    redirect_to root_path if @user != current_user
  end
end
