# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authorize
  before_action :set_i18n_locale_from_params
  before_action :set_query

  include Pagy::Backend

  protected

  def authorize
    return if User.find_by(id: session[:user_id])

    redirect_to login_path, notice: 'Please log in'
  end

  def set_query
    @q = Product.ransack(params[:q])
  end

  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
        session[:locale] = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    elsif session[:locale]
      I18n.locale = session[:locale]
    end
  end
end
