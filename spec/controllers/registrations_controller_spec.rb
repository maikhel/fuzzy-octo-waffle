require 'spec_helper'

RSpec.describe RegistrationsController, type: :controller do

  let(:field_of_study) { create(:field_of_study) }
  let(:valid_attributes) { attributes_for(:registration, field_of_study_id: field_of_study.id) }
  let(:invalid_attributes) { attributes_for(:registration, start_date: nil) }

  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "assigns @registrations" do
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

  describe "POST #create" do

    context "with valid params" do
      it "creates a new Registration" do
        expect {
          post :create, registration: valid_attributes
        }.to change(Registration, :count).by(1)
      end

      it "assigns a newly created registration as @registration" do
        post :create, registration: valid_attributes
        expect(assigns(:registration)).to be_a(Registration)
        expect(assigns(:registration)).to be_persisted
      end

      it "redirects to the created registration" do
        post :create, registration: valid_attributes
        group = Registration.last
        expect(response).to redirect_to registrations_path
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved registration as @registration" do
        post :create, registration: invalid_attributes
        expect(assigns(:registration)).to be_a_new(Registration)
      end

      it "re-renders the 'new' template" do
        post :create, registration: invalid_attributes
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do

    it "assigns @registration " do
      registration = create(:registration)
      put :update, {
        id: registration.id,
        registration: valid_attributes
      }
      expect(assigns(:registration)).to eq(registration)
    end

    context "with valid params" do

      it "updates the requested registration" do
        registration = create(:registration)
        new_field = create(:field_of_study)
        put :update, {
          id: registration.id,
          registration: attributes_for(:registration, field_of_study_id: new_field.id)
        }
        registration.reload
        expect(registration.field_of_study).to eq new_field
      end

      it "redirects to the registrations path" do
        registration = create(:registration)
        put :update, {
          id: registration.id,
          registration: valid_attributes
        }
        expect(response).to redirect_to registrations_path
      end
    end

    context "with invalid params" do
      it "re-renders the 'edit' template" do
        registration = create(:registration)
        put :update, {
          id: registration.id,
          registration: invalid_attributes
        }
        expect(response).to render_template("edit")
      end
    end
  end

end