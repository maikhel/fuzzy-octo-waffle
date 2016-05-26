require 'spec_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET show' do
    it "has a 200 status code" do
      user = create(:user)
      get :show, id: user.id
      expect(response.status).to eq(200)
    end

    it "assigns @users" do
      user = create(:user)
      get :show, id: user.id
      expect(assigns(:user)).to eq user
    end

    it "renders the show template" do
      user = create(:user)
      get :show, id: user.id
      expect(response).to render_template("show")
    end

  end
end