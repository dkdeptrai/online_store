# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authorize

  protected

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_path, notice: 'Please log in'
    end
  end
end
