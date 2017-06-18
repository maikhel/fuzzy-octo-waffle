require 'spec_helper'

RSpec.describe SemestersController, type: :controller do
  before(:all) do
    @field_of_study = create(:field_of_study)
    @lecturer = create(:lecturer)
  end

  let(:valid_attributes) { attributes_for(:semester).merge(field_of_study_id: @field_of_study.id) }
  let(:invalid_attributes) { attributes_for(:semester, start_date: nil, end_date: nil) }

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'has a 200 status code' do
      get :index, field_of_study_id: @field_of_study.id
      expect(response.status).to eq(200)
    end

    it 'assigns @field_of_study and @semesters' do
      create_list(:semester, 3)
      get :index, field_of_study_id: @field_of_study.id
      expect(assigns(:semesters)).to eq(@field_of_study.semesters)
      expect(assigns(:field_of_study)).to eq(@field_of_study)
    end

    it 'renders the index template' do
      get :index, field_of_study_id: @field_of_study.id
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    let(:semester) { create(:semester, field_of_study: @field_of_study) }

    it 'has a 200 status code' do
      get :show, field_of_study_id: @field_of_study.id, id: semester.id
      expect(response.status).to eq(200)
    end

    it 'assigns the requested semester as @semester' do
      get :show, field_of_study_id: @field_of_study.id, id: semester.id
      expect(assigns(:semester)).to eq(semester)
      expect(assigns(:field_of_study)).to eq(@field_of_study)
    end

    it 'renders the show template' do
      get :show, field_of_study_id: @field_of_study.id, id: semester.id
      expect(response).to render_template('show')
    end
  end

  describe 'GET #new' do
    it 'has a 200 status code' do
      get :new, field_of_study_id: @field_of_study.id
      expect(response.status).to eq(200)
    end

    it 'assigns a new semester as @semester' do
      get :new, field_of_study_id: @field_of_study.id
      expect(assigns(:semester)).to be_a_new Semester
    end

    it 'renders the new template' do
      get :new, field_of_study_id: @field_of_study.id
      expect(response).to render_template('new')
    end
  end

  describe 'GET #edit' do
    let(:semester) { create(:semester) }

    it 'has a 200 status code' do
      get :edit, field_of_study_id: semester.field_of_study.id, id: semester.id
      expect(response.status).to eq(200)
    end

    it 'assigns @semester and @@field_of_study' do
      get :edit, field_of_study_id: semester.field_of_study.id, id: semester.id
      expect(assigns(:semester)).to eq(semester)
      expect(assigns(:field_of_study)).to eq(semester.field_of_study)
    end

    it 'renders the new template' do
      get :edit, field_of_study_id: semester.field_of_study.id, id: semester.id
      expect(response).to render_template('edit')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Semester' do
        expect do
          post :create, semester: valid_attributes, field_of_study_id: @field_of_study.id
        end.to change(Semester, :count).by(1)
      end

      it 'assigns a newly created semester as @semester' do
        post :create, semester: valid_attributes, field_of_study_id: @field_of_study.id
        expect(assigns(:semester)).to be_a(Semester)
        expect(assigns(:semester)).to be_persisted
      end

      it 'redirects to semesters' do
        post :create, semester: valid_attributes, field_of_study_id: @field_of_study.id
        semester = Semester.last
        expect(response).to redirect_to field_of_study_semesters_path(semester.field_of_study_id)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved semester as @semester' do
        post :create, semester: invalid_attributes, field_of_study_id: @field_of_study.id
        expect(assigns(:semester)).to be_a_new Semester
      end

      it "re-renders the 'new' template" do
        post :create, semester: invalid_attributes, field_of_study_id: @field_of_study.id
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    it 'assigns @semester and @@field_of_study' do
      semester = create(:semester)
      put :update, field_of_study_id: semester.field_of_study_id,
                   id: semester.id,
                   semester: attributes_for(:semester, start_date: Date.today - 2.weeks)
      expect(assigns(:semester)).to eq(semester)
      expect(assigns(:field_of_study)).to eq(semester.field_of_study)
    end

    context 'with valid params' do
      let(:semester) { create(:semester) }

      it 'updates the requested semester' do
        put :update, field_of_study_id: semester.field_of_study_id,
                     id: semester.id,
                     semester: attributes_for(:semester, period_type: 'summer')
        semester.reload
        expect(semester.period_type).to eq 'summer'
      end

      it 'redirects to the semester' do
        put :update, field_of_study_id: semester.field_of_study_id,
                     id: semester.id,
                     semester: attributes_for(:semester, start_date: Date.today)
        expect(response).to redirect_to field_of_study_semesters_path(semester.field_of_study_id)
      end
    end

    context 'with invalid params' do
      it "re-renders the 'edit' template" do
        semester = create(:semester)
        put :update, field_of_study_id: semester.field_of_study_id,
                     id: semester.id,
                     semester: attributes_for(:semester, start_date: nil)
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested semester' do
      semester = create(:semester)
      diff = -1
      expect do
        delete :destroy, field_of_study_id: semester.field_of_study_id, id: semester.id
      end.to change(Semester, :count).by diff
    end

    it 'redirects to the semesters list' do
      semester = create(:semester)
      delete :destroy, field_of_study_id: semester.field_of_study_id, id: semester.id
      expect(response).to redirect_to field_of_study_semesters_path(semester.field_of_study_id)
    end
  end

  describe 'GET #add_students' do
    let(:semester) { create(:semester) }
    let(:field_of_study) { semester.field_of_study }
    let(:students) { create_list(:student, 3) }

    it 'adds students to semester' do
      get :add_students, field_of_study_id: field_of_study.id, id: semester.id, student_ids: students.map(&:id)
      expect(students).to eq semester.students
    end

    it 'has a 302 status code' do
      get :add_students, field_of_study_id: field_of_study.id, id: semester.id
      expect(response.status).to eq(302)
    end

    it 'assigns the @semester' do
      get :add_students, field_of_study_id: field_of_study.id, id: semester.id
      expect(assigns(:semester)).to eq semester
    end

    it 'redirects to show action' do
      get :add_students, field_of_study_id: field_of_study.id, id: semester.id
      expect(
        response
      ).to redirect_to field_of_study_semester_path(field_of_study_id: field_of_study.id, id: semester.id)
    end
  end

  describe 'DELETE #remove_students' do
    let(:semester) { create(:semester) }
    let(:field_of_study) { semester.field_of_study }
    let(:students) { create_list(:student, 3) }
    before(:each) { SemesterJoiner.new(semester).join(students) }

    it 'removes students from semester' do
      student = students.first
      delete :remove_students, field_of_study_id: field_of_study.id, id: semester.id, student_ids: student.id
      expect(student).not_to be_in semester.students
    end

    it 'has a 302 status code' do
      delete :remove_students, field_of_study_id: field_of_study.id, id: semester.id, student_ids: students.first.id
      expect(response.status).to eq(302)
    end

    it 'assigns the @semester' do
      delete :remove_students, field_of_study_id: field_of_study.id, id: semester.id, student_ids: students.first.id
      expect(assigns(:semester)).to eq semester
    end

    it 'redirects to show action' do
      delete :remove_students, field_of_study_id: field_of_study.id, id: semester.id, student_ids: students.first.id
      expect(
        response
      ).to redirect_to field_of_study_semester_path(field_of_study_id: field_of_study.id, id: semester.id)
    end
  end
end
