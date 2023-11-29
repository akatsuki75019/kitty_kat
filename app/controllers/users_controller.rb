class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def check_user
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to root_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver_now
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  private 

  def user_params
    params.require(:user).permit(:nom, :email, :password)
  end
end

  def edit
  end

  def update
  end

  def destroy
  end

end
