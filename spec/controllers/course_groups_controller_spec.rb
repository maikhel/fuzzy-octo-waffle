require 'spec_helper'

RSpec.describe CourseGroupsController, type: :controller do

  before(:all) do
   @subject = create(:subject)
   @lecturer = create(:user)
  end

  let(:course) { create(:subject, :with_groups) }

  let(:valid_attributes) { attributes_for(:course_group).merge({subject_id: @subject.id, lecturer_id: @lecturer.id}) }
  let(:invalid_attributes) { attributes_for(:course_group, start_time: nil, end_time: nil) }

  let(:valid_session) { {} }

  describe "GET #index" do
    # subject { get :index, course_id: course.id }

    it "has a 200 status code" do
      get :index, subject_id: course.id
      expect(response.status).to eq(200)
    end

    it "assigns subject course_groups as @course_groups" do
      create_list(:course_group, 3)
      get :index, subject_id: course.id
      expect(assigns(:course_groups)).to eq(course.course_groups)
      expect(assigns(:course)).to eq(course)
    end

    it "renders the index template" do
      get :index, subject_id: course.id
      expect(response).to render_template("index")
    end
  end

  describe "GET #overview" do
    it "has a 200 status code" do
      get :overview
      expect(response.status).to eq(200)
    end

    it "assigns subject course_groups as @course_groups" do
      create_list(:course_group, 3)
      get :overview
      expect(assigns(:course_groups)).to eq(CourseGroup.all)
    end

    it "renders the overview template" do
      get :overview
      expect(response).to render_template("overview")
    end
  end

  describe "GET #show" do
    let(:group) { course.course_groups.first }

    it "has a 200 status code" do
      get :show, {subject_id: course.id, id: group.id}
      expect(response.status).to eq(200)
    end

    it "assigns the requested course_group as @course_group" do
      get :show, {subject_id: course.id, id: group.id}
      expect(assigns(:course_group)).to eq(group)
      expect(assigns(:course)).to eq(course)
    end

    it "renders the show template" do
      get :show, {subject_id: course.id, id: group.id}
      expect(response).to render_template("show")
    end
  end

  describe "GET #new" do

    it "has a 200 status code" do
      get :new, {subject_id: course.id}
      expect(response.status).to eq(200)
    end

    it "assigns a new course_group as @course_group" do
      get :new, {subject_id: course.id}
      expect(assigns(:course_group)).to be_a_new(CourseGroup)
    end

    it "renders the new template" do
      get :new, {subject_id: course.id}
      expect(response).to render_template('new')
    end
  end

  describe "GET #edit" do
    it "assigns the requested course_group as @course_group" do
      course_group = create(:course_group)
      get :edit, {:id => course_group.to_param}, valid_session
      expect(assigns(:course_group)).to eq(course_group)
    end
  end

  describe "POST #create" do

    context "with valid params" do
      it "creates a new CourseGroup" do
        expect {
          post :create, course_group: valid_attributes, subject_id: @subject.id
        }.to change(CourseGroup, :count).by(1)
      end

      it "assigns a newly created course_group as @course_group" do
        post :create, course_group: valid_attributes, subject_id: @subject.id
        expect(assigns(:course_group)).to be_a(CourseGroup)
        expect(assigns(:course_group)).to be_persisted
      end

      it "redirects to the created course_group" do
        post :create, course_group: valid_attributes, subject_id: @subject.id
        group = CourseGroup.last
        expect(response).to redirect_to subject_course_group_path(subject: group.subject, id: group.id)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved course_group as @course_group" do
        post :create, course_group: invalid_attributes, subject_id: @subject.id
        expect(assigns(:course_group)).to be_a_new(CourseGroup)
      end

      it "re-renders the 'new' template" do
        post :create, course_group: invalid_attributes, subject_id: @subject.id
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested course_group" do
        course_group = create(:course_group)
        put :update, {:id => course_group.to_param, :course_group => new_attributes}, valid_session
        course_group.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested course_group as @course_group" do
        course_group = create(:course_group)
        put :update, {:id => course_group.to_param, :course_group => valid_attributes}, valid_session
        expect(assigns(:course_group)).to eq(course_group)
      end

      it "redirects to the course_group" do
        course_group = create(:course_group)
        put :update, {:id => course_group.to_param, :course_group => valid_attributes}, valid_session
        expect(response).to redirect_to(course_group)
      end
    end

    context "with invalid params" do
      it "assigns the course_group as @course_group" do
        course_group = create(:course_group)
        put :update, {:id => course_group.to_param, :course_group => invalid_attributes}, valid_session
        expect(assigns(:course_group)).to eq(course_group)
      end

      it "re-renders the 'edit' template" do
        course_group = create(:course_group)
        put :update, {:id => course_group.to_param, :course_group => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested course_group" do
      course_group = create(:course_group)
      expect {
        delete :destroy, {:id => course_group.to_param}, valid_session
      }.to change(CourseGroup, :count).by(-1)
    end

    it "redirects to the course_groups list" do
      course_group = create(:course_group)
      delete :destroy, {:id => course_group.to_param}, valid_session
      expect(response).to redirect_to(course_groups_url)
    end
  end

end
