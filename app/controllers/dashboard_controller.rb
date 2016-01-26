class DashboardController < ApplicationController
  before_action :authenticate_user!
  layout 'application'

  def index
    @users = User.all
  end

end