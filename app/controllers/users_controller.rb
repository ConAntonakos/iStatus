class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update

  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update_attributes(user_params)
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render "edit"
    end
  end

  private

  def user_params
    params.required(:user).permit(:password, :password_confirmation)
  end
end