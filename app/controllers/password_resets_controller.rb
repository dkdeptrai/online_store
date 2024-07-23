# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  before_action :set_user_by_token, only: %i[edit update]
  def new; end

  def create
    if (user = User.find_by(email: params[:email]))
      PasswordMailer.with(
        user:,
        token: user.generate_token_for(:password_reset)
      ).password_reset.deliver_later
    end

    redirect_to root_path, notice: 'Check your email for password reset instructions'
  end

  def edit; end

  def update
    if @user.update(password_params)
      redirect_to new_session_path, notice: 'Your password has been reset, please log in!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user_by_token
    @user = User.find_by_token_for(:password_reset, params[:token])
    redirect_to new_password_reset_path, alert: 'Invalid token, please try again!' unless @user.present?
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
