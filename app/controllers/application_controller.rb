class ApplicationController < ActionController::Base
  # before_action :authorize
  before_action :set_i18n_locale_from_params
  before_action :set_locale

  protected

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: " Please log in"
    end
  end

  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { :locale => I18n.locale }
  end

  def validate_user
    begin
      tmp = User.find(params[:id])
    rescue
      session[:user_id] = nil
      session[:update] = false
      redirect_to store_index_url, notice: "User not exist."
    else
    end
  end
end
