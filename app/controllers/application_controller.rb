class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery
  before_action :authenticate_user!

  layout :layout_by_resource
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:index_num, :email, :password, :password_confirmation, :remember_me) }
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :index_num, :email, :password, :remember_me) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:index_num, :email, :password, :password_confirmation, :current_password) }
    end

  private
    def set_user_locale
      session[:locale] = params.fetch(:locale) if params[:locale]
    end

    def set_locale
      I18n.locale = session[:locale] || params[:locale] || I18n.default_locale
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

    def layout_by_resource
      devise_controller? ? "devise" : "application"
    end

    def user_not_authorized
      redirect_to root_path
    end
end
