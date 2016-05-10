require 'spec_helper'
require 'devise'

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
      expect(assigns(:subject)).to eq(course)
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
      expect(assigns(:subject)).to eq(course)
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
    let(:group) { create(:course_group) }

    it "has a 200 status code" do
      get :edit, {subject_id: group.subject.id, id: group.id }
      expect(response.status).to eq(200)
    end

    it "assigns @course_group and @course" do
      get :edit, {subject_id: group.subject.id, id: group.id }
      expect(assigns(:course_group)).to eq(group)
      expect(assigns(:subject)).to eq(group.subject)
    end

    it "renders the new template" do
      get :edit, {subject_id: group.subject.id, id: group.id }
      expect(response).to render_template('edit')
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

    it "assigns @course_group and @course" do
      course_group = create(:course_group)
      put :update, {
        subject_id: course_group.subject_id,
        id: course_group.id,
        course_group: attributes_for(:course_group, max_limit: 20)
      }
      expect(assigns(:course_group)).to eq(course_group)
      expect(assigns(:subject)).to eq(course_group.subject)
    end

    context "with valid params" do
      it "updates the requested course_group" do
        course_group = create(:course_group)
        put :update, {
          subject_id: course_group.subject_id,
          id: course_group.id,
          course_group: attributes_for(:course_group, max_limit: 20)
        }
        course_group.reload
        expect(course_group.max_limit).to eq 20
      end

      it "redirects to the course_group" do
        course_group = create(:course_group)
        put :update, {
          subject_id: course_group.subject_id,
          id: course_group.id,
          course_group: attributes_for(:course_group, max_limit: 20)
        }
        expect(response).to redirect_to(subject_course_groups_path(course_group.subject_id))
      end
    end

    context "with invalid params" do
      it "re-renders the 'edit' template" do
        course_group = create(:course_group)
        put :update, {
          subject_id: course_group.subject_id,
          id: course_group.id,
          course_group: attributes_for(:course_group, weekday: nil)
        }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested course_group" do
      course_group = create(:course_group)
      expect {
        delete :destroy, subject_id: course_group.subject_id, id: course_group.id
      }.to change(CourseGroup, :count).by(-1)
    end

    it "redirects to the course_groups list" do
      course_group = create(:course_group)
      delete :destroy, subject_id: course_group.subject_id, id: course_group.id
      expect(response).to redirect_to(subject_course_groups_path(course_group.subject_id))
    end
  end

  describe 'GET #registrate' do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @lecturer
    end
    let(:group) { course.course_groups.first }

    it 'registrates user to group' do
      get :registrate, {subject_id: course.id, id: group.id}
      expect(@lecturer.course_groups).to include group
    end


    it "has a 302 status code" do
      get :registrate, {subject_id: course.id, id: group.id}
      expect(response.status).to eq(302)
    end

    it "assigns the course_group as @course_group" do
      get :registrate, {subject_id: course.id, id: group.id}
      expect(assigns(:course_group)).to eq group
      expect(assigns(:subject)).to eq course
    end

    it "redirects to show action" do
      get :registrate, {subject_id: course.id, id: group.id}
      expect(response).to redirect_to subject_course_group_path(subject_id: course.id, id: group.id)
    end
  end

  describe 'GET #deregistrate' do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @lecturer
      CourseGroupJoiner.new(group).enroll(@lecturer)
    end

    let(:group) { course.course_groups.first }

    it 'deregistrated user from course group' do
      get :deregistrate, {subject_id: course.id, id: group.id}
      expect(@lecturer.course_groups).not_to include group
    end


    it "has a 302 status code" do
      get :deregistrate, {subject_id: course.id, id: group.id}
      expect(response.status).to eq(302)
    end

    it "assigns the course_group as @course_group" do
      get :deregistrate, {subject_id: course.id, id: group.id}
      expect(assigns(:course_group)).to eq group
      expect(assigns(:subject)).to eq course
    end

    it "redirects to show action" do
      get :deregistrate, {subject_id: course.id, id: group.id}
      expect(response).to redirect_to subject_course_group_path(subject_id: course.id, id: group.id)
    end
  end

end
