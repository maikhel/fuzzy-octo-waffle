require 'spec_helper'
require 'devise'

RSpec.describe GradesController, type: :controller do

  before(:all) do
    @course_group = create(:course_group)
    @student = create(:student)
  end

  let(:valid_attributes) {attributes_for(:grade).merge({user_id: @student.id}) }

  describe "POST create" do
    context 'with valid attributes' do
      it "creates a new grade" do
        expect{
          post :create, grades: {"1" => valid_attributes}, course_group_id: @course_group.id
        }.to change{ Grade.count }.by 1
      end

      # it "redirects to show coure group path" do
      #   post :create, valid_attributes, course_group_id: @course_group.id
      #   expect(response).to redirect_to redirect_to subject_course_group_path(subject_id: @course_group.subject.id, id: @course_group.id)
      # end
    end

    # context 'with invalid attributes' do
    #   it "does not save the new record" do
    #     expect{
    #       post :create, field_of_study: attributes_for(:field_of_study, title: nil)
    #     }.to_not change{ FieldOfStudy.count }
    #   end

    #   it "re-renders the new method" do
    #     post :create, field_of_study: attributes_for(:field_of_study, title: nil)
    #     expect(response).to render_template(:new)
    #   end
    # end
  end

end