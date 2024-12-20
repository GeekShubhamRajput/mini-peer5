class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.p5_balance = 100
    @user.reward_balance = 0
    if @user.save
      redirect_to users_path, notice: 'User created successfully!'
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: 'User updated successfully!'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
