require 'spec_helper'

RSpec.describe RegistrationsController, type: :controller do

  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "assigns @registrations and @course_groups" do
      create_list(:registration, 3)
      get :index
      expect(assigns(:registrations)).to eq(Registration.all)
      expect(assigns(:course_groups)).to eq(CourseGroup.all)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #new" do

    it "has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end

    it "assigns a new registration as @registration" do
      get :new
      expect(assigns(:registration)).to be_a_new(Registration)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe "GET #edit" do
    let(:registration) { create(:registration) }

    it "has a 200 status code" do
      get :edit, id: registration.id
      expect(response.status).to eq(200)
    end

    it "assigns @registration and @course" do
      get :edit, id: registration.id
      expect(assigns(:registration)).to eq(registration)
    end

    it "renders the new template" do
      get :edit, id: registration.id
      expect(response).to render_template('edit')
    end
  end

end