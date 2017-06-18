require 'spec_helper'

RSpec.describe CourseGroupsController, type: :controller do
  before(:all) do
    @subject = create(:subject)
    @lecturer = create(:lecturer)
  end

  let(:course) { create(:subject, :with_groups) }

  let(:valid_attributes) { attributes_for(:course_group).merge(subject_id: @subject.id, lecturer_id: @lecturer.id) }
  let(:invalid_attributes) { attributes_for(:course_group, start_time: nil, end_time: nil) }

  let(:valid_session) { {} }

  describe 'GET #index' do
    # subject { get :index, course_id: course.id }

    it 'has a 200 status code' do
      get :index, subject_id: course.id
      expect(response.status).to eq(200)
    end

    it 'assigns subject course_groups as @course_groups' do
      create_list(:course_group, 3)
      get :index, subject_id: course.id
      expect(assigns(:course_groups)).to eq(course.course_groups.order(:start_time))
      expect(assigns(:subject)).to eq(course)
    end

    it 'renders the index template' do
      get :index, subject_id: course.id
      expect(response).to render_template('index')
    end
  end

  describe 'GET #overview' do
    it 'has a 200 status code' do
      get :overview
      expect(response.status).to eq(200)
    end

    it 'assigns subject course_groups as @course_groups' do
      create_list(:course_group, 3)
      get :overview
      expect(assigns(:course_groups)).to eq(CourseGroup.all)
    end

    it 'renders the overview template' do
      get :overview
      expect(response).to render_template('overview')
    end
  end

  describe 'GET #show' do
    let(:group) { course.course_groups.first }

    it 'has a 200 status code' do
      get :show, subject_id: course.id, id: group.id
      expect(response.status).to eq(200)
    end

    it 'assigns the requested course_group as @course_group' do
      get :show, subject_id: course.id, id: group.id
      expect(assigns(:course_group)).to eq(group)
      expect(assigns(:subject)).to eq(course)
    end

    it 'renders the show template' do
      get :show, subject_id: course.id, id: group.id
      expect(response).to render_template('show')
    end
  end

  describe 'GET #new' do
    it 'has a 200 status code' do
      get :new, subject_id: course.id
      expect(response.status).to eq(200)
    end

    it 'assigns a new course_group as @course_group' do
      get :new, subject_id: course.id
      expect(assigns(:course_group)).to be_a_new(CourseGroup)
    end

    it 'renders the new template' do
      get :new, subject_id: course.id
      expect(response).to render_template('new')
    end
  end

  describe 'GET #edit' do
    let(:group) { create(:course_group) }

    it 'has a 200 status code' do
      get :edit, subject_id: group.subject.id, id: group.id
      expect(response.status).to eq(200)
    end

    it 'assigns @course_group and @course' do
      get :edit, subject_id: group.subject.id, id: group.id
      expect(assigns(:course_group)).to eq(group)
      expect(assigns(:subject)).to eq(group.subject)
    end

    it 'renders the new template' do
      get :edit, subject_id: group.subject.id, id: group.id
      expect(response).to render_template('edit')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new CourseGroup' do
        expect do
          post :create, course_group: valid_attributes, subject_id: @subject.id
        end.to change(CourseGroup, :count).by(1)
      end

      it 'assigns a newly created course_group as @course_group' do
        post :create, course_group: valid_attributes, subject_id: @subject.id
        expect(assigns(:course_group)).to be_a(CourseGroup)
        expect(assigns(:course_group)).to be_persisted
      end

      it 'creates CalendarEvents' do
        expect do
          post :create, course_group: valid_attributes, subject_id: @subject.id
        end.to change(CalendarEvent, :count)
      end

      it 'redirects to the created course_group' do
        post :create, course_group: valid_attributes, subject_id: @subject.id
        group = CourseGroup.last
        expect(response).to redirect_to subject_course_group_path(subject: group.subject, id: group.id)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved course_group as @course_group' do
        post :create, course_group: invalid_attributes, subject_id: @subject.id
        expect(assigns(:course_group)).to be_a_new(CourseGroup)
      end

      it "re-renders the 'new' template" do
        post :create, course_group: invalid_attributes, subject_id: @subject.id
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    it 'assigns @course_group and @course' do
      course_group = create(:course_group)
      put :update, subject_id: course_group.subject_id,
                   id: course_group.id,
                   course_group: attributes_for(:course_group, max_limit: 20)
      expect(assigns(:course_group)).to eq(course_group)
      expect(assigns(:subject)).to eq(course_group.subject)
    end

    context 'with valid params' do
      let(:course_group) { create(:course_group) }

      it 'updates the requested course_group' do
        put :update,           subject_id: course_group.subject_id,
                               id: course_group.id,
                               course_group: attributes_for(:course_group, max_limit: 20)
        course_group.reload
        expect(course_group.max_limit).to eq 20
      end

      xit 'updates course_group.calendar_events' do
        CalendarEventsCreator.new(course_group).run
        put :update, subject_id: course_group.subject_id,
                     id: course_group.id,
                     course_group: attributes_for(:course_group, start_time: '2000-01-01 18:00:00 UTC')
        course_group.reload
        expect(course_group.calendar_events.last.start_date.strftime('%H:%M')).to eq '18:00'
      end

      it 'redirects to the course_group' do
        put :update,           subject_id: course_group.subject_id,
                               id: course_group.id,
                               course_group: attributes_for(:course_group, max_limit: 20)
        expect(response).to redirect_to(subject_course_groups_path(course_group.subject_id))
      end
    end

    context 'with invalid params' do
      it "re-renders the 'edit' template" do
        course_group = create(:course_group)
        put :update, subject_id: course_group.subject_id,
                     id: course_group.id,
                     course_group: attributes_for(:course_group, weekday: nil)
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested course_group' do
      course_group = create(:course_group)
      expect do
        delete :destroy, subject_id: course_group.subject_id, id: course_group.id
      end.to change(CourseGroup, :count).by(-1)
    end

    it 'redirects to the course_groups list' do
      course_group = create(:course_group)
      delete :destroy, subject_id: course_group.subject_id, id: course_group.id
      expect(response).to redirect_to(subject_course_groups_path(course_group.subject_id))
    end
  end

  describe 'GET #registrate' do
    let(:group) { course.course_groups.first }

    it 'registrates user to group' do
      get :registrate, subject_id: course.id, id: group.id
      # Admin.first is now current user
      expect(Admin.first.course_groups).to include group
    end

    it 'has a 302 status code' do
      get :registrate, subject_id: course.id, id: group.id
      expect(response.status).to eq(302)
    end

    it 'assigns the course_group as @course_group' do
      get :registrate, subject_id: course.id, id: group.id
      expect(assigns(:course_group)).to eq group
      expect(assigns(:subject)).to eq course
    end

    it 'redirects to show action' do
      get :registrate, subject_id: course.id, id: group.id
      expect(response).to redirect_to subject_course_group_path(subject_id: course.id, id: group.id)
    end
  end

  describe 'GET #deregistrate' do
    let(:group) { course.course_groups.first }
    let(:student) { create(:student) }

    it 'deregistrates user from course group' do
      get :deregistrate, subject_id: course.id, id: group.id
      expect(student.course_groups).not_to include group
    end

    it 'has a 302 status code' do
      get :deregistrate, subject_id: course.id, id: group.id
      expect(response.status).to eq(302)
    end

    it 'assigns the course_group as @course_group' do
      get :deregistrate, subject_id: course.id, id: group.id
      expect(assigns(:course_group)).to eq group
      expect(assigns(:subject)).to eq course
    end

    it 'redirects to show action' do
      get :deregistrate, subject_id: course.id, id: group.id
      expect(response).to redirect_to subject_course_group_path(subject_id: course.id, id: group.id)
    end
  end

  describe 'POST update_grades' do
    before(:all) do
      @course_group = create(:course_group)
      @student = create(:student)
      @student2 = create(:student)
    end

    let(:sample_hash) { { user_id: @student.id, value: 3.0 } }
    let(:another_hash) { { user_id: @student2.id, value: 4.5 } }

    context 'with valid attributes' do
      it 'creates a new grade' do
        expect do
          post :update_grades, grades: [sample_hash], id: @course_group.id, subject_id: @course_group.subject.id
        end.to change { Grade.count }.by 1
      end

      it 'updates existing grade' do
        grade = create(:grade, user_id: @student.id, course_group: @course_group, value: 4)
        post :update_grades, grades: [sample_hash], id: @course_group.id, subject_id: @course_group.subject.id
        grade.reload
        expect(grade.value).to eq 3
      end

      it 'creates many new grades' do
        params = {
          grades: [sample_hash, another_hash],
          id: @course_group.id,
          subject_id: @course_group.subject.id
        }
        expect do
          post :update_grades, params
        end.to change { Grade.count }.by 2
      end

      it 'updates many grades' do
        grade = create(:grade, user_id: @student.id, course_group: @course_group, value: 4)
        grade2 = create(:grade, user_id: @student2.id, course_group: @course_group, value: 3)
        params = {
          grades: [sample_hash, another_hash],
          id: @course_group.id,
          subject_id: @course_group.subject.id
        }

        post :update_grades, params

        grade.reload
        grade2.reload
        expect(grade.value).to eq 3
        expect(grade2.value).to eq 4.5
      end

      it 'redirects to show coure group path' do
        post :update_grades, grades: [sample_hash], id: @course_group.id, subject_id: @course_group.subject.id
        expect(
          response
        ).to redirect_to subject_course_group_path(subject_id: @course_group.subject.id, id: @course_group.id)
      end

      xit 'sends email after updating grade' do
        expect do
          post :update_grades, grades: [sample_hash], id: @course_group.id, subject_id: @course_group.subject.id
        end.to change { ActionMailer::Base.deliveries.count }.by 1
      end

      xit 'sends email for many students' do
        params = {
          grades: [sample_hash, another_hash],
          id: @course_group.id,
          subject_id: @course_group.subject.id
        }
        expect do
          post :update_grades, params
        end.to change { ActionMailer::Base.deliveries.count }.by 2
      end

      xit 'sends email only if grade was changed' do
        create(:grade, user_id: @student.id, course_group: @course_group, value: 3.0)
        params = {
          grades: [sample_hash, another_hash],
          id: @course_group.id,
          subject_id: @course_group.subject.id
        }
        expect do
          post :update_grades, params
        end.to change { ActionMailer::Base.deliveries.count }.by 1
      end
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
