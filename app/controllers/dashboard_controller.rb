class DashboardController < ActionController::Base
  before_action :authenticate_user!
  layout 'application'

  def index
    @users = User.all
  end

end