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

  describe 'GET show' do
    it "has a 200 status code" do
      subject = create(:subject)
      get :show, id: subject.id
      expect(response.status).to eq(200)
    end

    it "assigns @subjects" do
      subject = create(:subject)
      get :show, id: subject.id
      expect(assigns(:subject)).to eq subject
    end

    it "renders the show template" do
      subject = create(:subject)
      get :show, id: subject.id
      expect(response).to render_template("show")
    end

  end

  describe "GET new" do
    it "has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end

    it "assigns @subjects" do
      get :new
      expect(assigns(:subject)).to be_a Subject
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    context 'with valid attributes' do
      it "creates a new subject" do
        expect{
          post :create, subject: attributes_for(:subject)
        }.to change{ Subject.count }.by 1
      end

      it "redirects to the index path" do
        post :create, subject: attributes_for(:subject)
        expect(response).to redirect_to subjects_path
      end
    end

    context 'with invalid attributes' do
      it "does not save the new contact" do
        expect{
          post :create, subject: attributes_for(:subject, title: nil)
        }.to_not change{ Subject.count }
      end

      it "re-renders the new method" do
        post :create, subject: attributes_for(:subject, title: nil)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET edit" do
    it "has a 200 status code" do
      subject = create(:subject)
      get :edit, id: subject.id
      expect(response.status).to eq(200)
    end

    it "assigns @subjects" do
      subject = create(:subject)
      get :edit, id: subject.id
      expect(assigns(:subject)).to be_a Subject
    end

    it "renders the edit template" do
      subject = create(:subject)
      get :edit, id: subject.id
      expect(response).to render_template("edit")
    end
  end

  describe "PATCH update" do
    context 'with valid attributes' do
      it "updates a subject" do
        subject = create(:subject)
        patch :update, id: subject.id, subject: attributes_for(:subject, title: 'new title')
        subject.reload
        expect(subject.title).to eq 'new title'
      end

      it "redirects to the index path" do
        subject = create(:subject)
        patch :update, id: subject.id, subject: attributes_for(:subject, title: 'new title')
        expect(response).to redirect_to subject_path(subject)
      end
    end

    context 'with invalid attributes' do
      it 'does not update subject' do
        subject = create(:subject, title: 'old title')
        patch :update, id: subject.id, subject: attributes_for(:subject, title: nil)
        subject.reload
        expect(subject.title).to eq 'old title'
      end

      it 're-renders the edit action' do
        subject = create(:subject, title: 'old title')
        patch :update, id: subject.id, subject: attributes_for(:subject, title: nil)
        expect(response).to render_template(:edit)
      end
    end
  end

end