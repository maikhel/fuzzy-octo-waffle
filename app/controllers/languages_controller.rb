class LanguagesController < ApplicationController

  def change
    session[:locale] = params[:locale] if valid_locale? params[:locale].to_sym
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path #after_sign_in_path_for(current_user)
  end

  private
  def valid_locale?(locale)
    I18n.available_locales.include? locale
  end
end