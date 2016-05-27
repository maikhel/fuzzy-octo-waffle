RSpec.configure do |config|

  config.before(:each, type: :controller) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in create(:admin)
  end

end
