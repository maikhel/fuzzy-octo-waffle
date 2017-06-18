class FieldOfStudiesController < ApplicationController
  before_action :set_field_of_study, only: %i[show edit update destroy]

  # GET /field_of_studies
  def index
    @field_of_studies = FieldOfStudy.all
  end

  # GET /field_of_studies/1
  def show
    authorize @field_of_study
  end

  # GET /field_of_studies/new
  def new
    @field_of_study = FieldOfStudy.new
    authorize @field_of_study
  end

  # GET /field_of_studies/1/edit
  def edit
    authorize @field_of_study
  end

  # POST /field_of_studies
  def create
    @field_of_study = FieldOfStudy.new(field_of_study_params)
    authorize @field_of_study

    respond_to do |format|
      if @field_of_study.save
        format.html { redirect_to field_of_studies_path }
      else
        format.html { render :new }
        format.json { render json: @field_of_study.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /field_of_studies/1
  def update
    authorize @field_of_study

    respond_to do |format|
      if @field_of_study.update(field_of_study_params)
        format.html { redirect_to field_of_studies_path }
      else
        format.html { render :edit }
        format.json { render json: @field_of_study.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /field_of_studies/1
  def destroy
    authorize @field_of_study

    @field_of_study.destroy
    respond_to do |format|
      format.html { redirect_to field_of_studies_path }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_field_of_study
    @field_of_study = FieldOfStudy.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def field_of_study_params
    params.require(:field_of_study).permit(:title, :mode, :degree, :dean_id, :faculty_id)
  end
end
