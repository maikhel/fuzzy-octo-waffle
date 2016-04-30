require 'spec_helper'

RSpec.describe FieldOfStudiesController, type: :controller do

  # let(:valid_attributes) {
  #   skip("Add a hash of attributes valid for your model")
  # }

  # let(:invalid_attributes) {
  #   skip("Add a hash of attributes invalid for your model")
  # }

  # let(:valid_session) { {} }

  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "assigns @field_of_studies" do
      create_list(:field_of_study, 3)
      get :index
      expect(assigns(:field_of_studies)).to eq(FieldOfStudy.all)
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

    it "assigns a new @field_of_study" do
      get :new
      expect(assigns(:field_of_study)).to be_a_new(FieldOfStudy)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe "POST create" do
    let(:faculty) { create(:faculty) }
    context 'with valid attributes' do
      it "creates a new field_of_study" do
        expect{
          post :create, field_of_study: attributes_for(:field_of_study, faculty_id: faculty.id)
        }.to change{ FieldOfStudy.count }.by 1
      end

      it "redirects to the index path" do
        post :create, field_of_study: attributes_for(:field_of_study, faculty_id: faculty.id)
        expect(response).to redirect_to field_of_studies_path
      end
    end

    context 'with invalid attributes' do
      it "does not save the new record" do
        expect{
          post :create, field_of_study: attributes_for(:field_of_study, title: nil)
        }.to_not change{ FieldOfStudy.count }
      end

      it "re-renders the new method" do
        post :create, field_of_study: attributes_for(:field_of_study, title: nil)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    let(:field) { create(:field_of_study) }

    it "has a 200 status code" do
      get :edit, id: field.id
      expect(response.status).to eq(200)
    end

    it "assigns @field_of_study" do
      get :edit, id: field.id
      expect(assigns(:field_of_study)).to eq(field)
    end

    it "renders the edit template" do
      get :edit, id: field.id
      expect(response).to render_template('edit')
    end
  end
  # describe "GET #show" do
  #   it "assigns the requested field_of_study as @field_of_study" do
  #     field_of_study = FieldOfStudy.create! valid_attributes
  #     get :show, {:id => field_of_study.to_param}, valid_session
  #     expect(assigns(:field_of_study)).to eq(field_of_study)
  #   end
  # end

  # describe "GET #new" do
  #   it "assigns a new field_of_study as @field_of_study" do
  #     get :new, {}, valid_session
  #     expect(assigns(:field_of_study)).to be_a_new(FieldOfStudy)
  #   end
  # end

  # describe "GET #edit" do
  #   it "assigns the requested field_of_study as @field_of_study" do
  #     field_of_study = FieldOfStudy.create! valid_attributes
  #     get :edit, {:id => field_of_study.to_param}, valid_session
  #     expect(assigns(:field_of_study)).to eq(field_of_study)
  #   end
  # end

  # describe "POST #create" do
  #   context "with valid params" do
  #     it "creates a new FieldOfStudy" do
  #       expect {
  #         post :create, {:field_of_study => valid_attributes}, valid_session
  #       }.to change(FieldOfStudy, :count).by(1)
  #     end

  #     it "assigns a newly created field_of_study as @field_of_study" do
  #       post :create, {:field_of_study => valid_attributes}, valid_session
  #       expect(assigns(:field_of_study)).to be_a(FieldOfStudy)
  #       expect(assigns(:field_of_study)).to be_persisted
  #     end

  #     it "redirects to the created field_of_study" do
  #       post :create, {:field_of_study => valid_attributes}, valid_session
  #       expect(response).to redirect_to(FieldOfStudy.last)
  #     end
  #   end

  #   context "with invalid params" do
  #     it "assigns a newly created but unsaved field_of_study as @field_of_study" do
  #       post :create, {:field_of_study => invalid_attributes}, valid_session
  #       expect(assigns(:field_of_study)).to be_a_new(FieldOfStudy)
  #     end

  #     it "re-renders the 'new' template" do
  #       post :create, {:field_of_study => invalid_attributes}, valid_session
  #       expect(response).to render_template("new")
  #     end
  #   end
  # end

  # describe "PUT #update" do
  #   context "with valid params" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }

  #     it "updates the requested field_of_study" do
  #       field_of_study = FieldOfStudy.create! valid_attributes
  #       put :update, {:id => field_of_study.to_param, :field_of_study => new_attributes}, valid_session
  #       field_of_study.reload
  #       skip("Add assertions for updated state")
  #     end

  #     it "assigns the requested field_of_study as @field_of_study" do
  #       field_of_study = FieldOfStudy.create! valid_attributes
  #       put :update, {:id => field_of_study.to_param, :field_of_study => valid_attributes}, valid_session
  #       expect(assigns(:field_of_study)).to eq(field_of_study)
  #     end

  #     it "redirects to the field_of_study" do
  #       field_of_study = FieldOfStudy.create! valid_attributes
  #       put :update, {:id => field_of_study.to_param, :field_of_study => valid_attributes}, valid_session
  #       expect(response).to redirect_to(field_of_study)
  #     end
  #   end

  #   context "with invalid params" do
  #     it "assigns the field_of_study as @field_of_study" do
  #       field_of_study = FieldOfStudy.create! valid_attributes
  #       put :update, {:id => field_of_study.to_param, :field_of_study => invalid_attributes}, valid_session
  #       expect(assigns(:field_of_study)).to eq(field_of_study)
  #     end

  #     it "re-renders the 'edit' template" do
  #       field_of_study = FieldOfStudy.create! valid_attributes
  #       put :update, {:id => field_of_study.to_param, :field_of_study => invalid_attributes}, valid_session
  #       expect(response).to render_template("edit")
  #     end
  #   end
  # end

  # describe "DELETE #destroy" do
  #   it "destroys the requested field_of_study" do
  #     field_of_study = FieldOfStudy.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => field_of_study.to_param}, valid_session
  #     }.to change(FieldOfStudy, :count).by(-1)
  #   end

  #   it "redirects to the field_of_studies list" do
  #     field_of_study = FieldOfStudy.create! valid_attributes
  #     delete :destroy, {:id => field_of_study.to_param}, valid_session
  #     expect(response).to redirect_to(field_of_studies_url)
  #   end
  # end

end
