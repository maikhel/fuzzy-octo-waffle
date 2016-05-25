require 'spec_helper'

RSpec.describe ModalsController, type: :controller do

  describe "GET select_users" do

    let(:course_group) { create(:course_group) }

    it "has a 200 status code" do
      get :select_users, course_group_id: course_group.id
      expect(response.status).to eq(200)
    end

    it "assigns @course_group, @students" do
      get :select_users, course_group_id: course_group.id
      expect(assigns(:course_group)).to eq course_group
      expect(assigns(:students)).to eq User.all
    end

    it "renders partial select_users_modal" do
      get :select_users, course_group_id: course_group.id
      expect(response).to render_template('modals/_select_users_modal')
    end
  end

  describe "GET update_grades" do

    let(:course_group) { create(:course_group_with_students) }

    it "has a 200 status code" do
      get :update_grades, course_group_id: course_group.id
      expect(response.status).to eq(200)
    end

    it "assigns @students" do
      get :update_grades, course_group_id: course_group.id
      expect(assigns(:students)).to eq course_group.users
    end

    it "renders partial update_grades_modal" do
      get :update_grades, course_group_id: course_group.id
      expect(response).to render_template('modals/_update_grades_modal')
    end
  end

end