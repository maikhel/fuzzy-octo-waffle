class SubjectsController < ApplicationController
  before_action :set_subject, only: %i[show edit update destroy]

  def index
    authorize Semester
    @semesters = policy_scope(Semester)
  end

  def new
    @subject = Subject.new
    authorize @subject
  end

  def create
    @subject = Subject.new(subject_params)
    authorize @subject

    respond_to do |format|
      if @subject.save
        format.html { redirect_to subjects_path, notice: 'subject was successfully created.' }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  def show; end

  def edit
    authorize @subject
  end

  def update
    authorize @subject
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to @subject, notice: 'subject was successfully updated.' }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @subject

    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_path }
      # format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subject
    @subject = Subject.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def subject_params
    params.require(:subject)
          .permit(
            :title,
            :description,
            :short_description,
            :literature,
            :requirements,
            :learning_outcomes,
            :semester_id
          )
  end
end
