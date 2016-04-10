require 'spec_helper'

RSpec.describe SubjectsController, type: :controller do

  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "assigns @subjects" do
      create_list(:subject, 3)
      get :index
      expect(assigns(:subjects)).to eq(Subject.all)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

end