class SemestersController < ApplicationController
  before_action :set_field_of_study_and_semester, only: [:show, :edit, :update, :destroy, :add_students]


  def index
    @field_of_study = FieldOfStudy.find params[:field_of_study_id]
    @semesters = @field_of_study.semesters
  end

  def show
    authorize @semester
  end

  def new
    @field_of_study = FieldOfStudy.find params[:field_of_study_id]
    @semester = Semester.new
    authorize @semester
  end

  def edit
    authorize @semester
  end

  def create
    @semester = Semester.new(semester_params)
    authorize @semester

    respond_to do |format|
      if @semester.save
        format.html { redirect_to field_of_study_semesters_path(@semester.field_of_study_id) }
      else
        format.html { render :new }
        format.json { render json: @semester.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @semester

    respond_to do |format|
      if @semester.update(semester_params)
        format.html { redirect_to field_of_study_semesters_path(@semester.field_of_study_id) }
      else
        format.html { render :edit }
        format.json { render json: @semester.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @semester

    @semester.destroy
    respond_to do |format|
      format.html { redirect_to field_of_study_semesters_path(@semester.field_of_study_id) }
    end
  end

  def add_students
    authorize @semester

    if params[:student_ids]
      students = Student.find params[:student_ids]
      SemesterJoiner.new(@semester).join(students)
    end
    redirect_to action: 'show', field_of_study: params[:field_of_study], id: params[:id]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_field_of_study_and_semester
      @field_of_study = FieldOfStudy.find params[:field_of_study_id]
      @semester = Semester.find params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def semester_params
      params.require(:semester).permit(:start_date, :end_date, :period_type, :field_of_study_id, :student_ids)
    end
end
