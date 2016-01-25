class WelcomeController < ActionController::Base
  before_action :authenticate_user!
  layout 'devise'

  def index
    @users = User.all
  end

end