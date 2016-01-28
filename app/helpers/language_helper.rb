module LanguageHelper
  def other_language
    session[:locale] == :pl || params[:locale] == :pl ? "en" : "pl"
  end
end
