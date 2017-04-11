class UsersController < ApplicationController
  def new
    @user =User.new
    # debugger
  end

  def show
    @user = User.find(params[:id])

    # debugger
  end

  def create
    @user= User.new(user_param)
    if @user.save
      #处理注册成功的情况
      flash[:success] = 'Welcome to Sample App!'
      # redirect_to user_url(@user)
      redirect_to @user
    else
      render 'new'
    end
  end

  private
    def user_param
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
