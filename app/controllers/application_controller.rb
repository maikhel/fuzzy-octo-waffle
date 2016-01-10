class ApplicationController < ActionController::Base

  before_action :set_locale
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def set_user_locale
      session[:locale] = params.fetch(:locale) if params[:locale]
    end

    def set_session_locale
      I18n.locale = session[:locale] if session[:locale]
    end

    def after_sign_out_path_for(resource)
      ENV['LOGOUT_URL']
    end

    # def after_sign_in_path_for(resource)
    #   if resource && resource.admin?
    #     rails_admin.dashboard_path
    #   elsif resource && resource.is_not_activated_customer?
    #     backend.locked_path
    #   else
    #     backend.companies_path
    #   end
    # end

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end
end
