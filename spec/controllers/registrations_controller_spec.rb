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

end