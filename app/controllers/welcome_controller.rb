class WelcomeController < ActionController::Base
  before_action :authenticate_user!

  def index
    @users = Users.all
  end

end