class FieldOfStudiesController < ApplicationController
  before_action :set_field_of_study, only: [:show, :edit, :update, :destroy]

  # GET /field_of_studies
  def index
    @field_of_studies = FieldOfStudy.all
  end

  # GET /field_of_studies/1
  # GET /field_of_studies/1.json
  def show
  end

  # GET /field_of_studies/new
  def new
    @field_of_study = FieldOfStudy.new
  end

  # GET /field_of_studies/1/edit
  def edit
  end

  # POST /field_of_studies
  # POST /field_of_studies.json
  def create
    @field_of_study = FieldOfStudy.new(field_of_study_params)

    respond_to do |format|
      if @field_of_study.save
        format.html { redirect_to @field_of_study, notice: 'Field of study was successfully created.' }
        format.json { render :show, status: :created, location: @field_of_study }
      else
        format.html { render :new }
        format.json { render json: @field_of_study.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /field_of_studies/1
  # PATCH/PUT /field_of_studies/1.json
  def update
    respond_to do |format|
      if @field_of_study.update(field_of_study_params)
        format.html { redirect_to @field_of_study, notice: 'Field of study was successfully updated.' }
        format.json { render :show, status: :ok, location: @field_of_study }
      else
        format.html { render :edit }
        format.json { render json: @field_of_study.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /field_of_studies/1
  # DELETE /field_of_studies/1.json
  def destroy
    @field_of_study.destroy
    respond_to do |format|
      format.html { redirect_to field_of_studies_url, notice: 'Field of study was successfully destroyed.' }
      format.json { head :no_content }
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
