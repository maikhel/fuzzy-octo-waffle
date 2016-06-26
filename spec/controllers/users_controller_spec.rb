require 'spec_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET show' do
    it "has a 200 status code" do
      user = create(:user)
      get :show, id: user.id
      expect(response.status).to eq(200)
    end

    it "assigns @user" do
      user = create(:student)
      get :show, id: user.id
      expect(assigns(:user)).to eq user
    end

    it "renders the show template" do
      user = create(:user)
      get :show, id: user.id
      expect(response).to render_template("show")
    end

  end

  describe 'GET edit_account' do
    it "has a 200 status code" do
      get :edit_account
      expect(response.status).to eq(200)
    end

    it "assigns @user" do
      get :edit_account
      expect(assigns(:user)).to eq Admin.first
    end

    it "renders the show template" do
      get :edit_account
      expect(response).to render_template("edit")
    end

  end

  describe 'GET my_study' do
    let(:user) { create(:student) }

    it "has a 200 status code" do
      get :my_study, id: user.id
      expect(response.status).to eq(200)
    end

    it "assigns @user" do
      get :my_study, id: user.id
      expect(assigns(:user)).to eq Admin.first
    end

    it "renders the my_study template" do
      get :my_study, id: user.id
      expect(response).to render_template("my_study")
    end

  end
end