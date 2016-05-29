class RegistrationsController < ApplicationController

  before_action :set_registration, only: [:show, :edit, :update, :destroy]

  def index
    authorize Registration
    @semesters = Semester.all
  end

  def new
    @registration = Registration.new
    authorize @registration
  end

  def edit
    authorize @registration
  end

  def create
    @registration = Registration.new(registration_params)
    authorize @registration

    respond_to do |format|
      if @registration.save
        format.html { redirect_to registrations_path }
      else
        format.html { render :new }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @registration

    respond_to do |format|
      if @registration.update(registration_params)
        format.html { redirect_to registrations_path }
        # format.json { render :show, status: :ok, location: @registration }
      else
        format.html { render :edit }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @registration

    @registration.destroy
    respond_to do |format|
      format.html { redirect_to registrations_path }
      # format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registration
      @registration = Registration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def registration_params
      params.require(:registration).permit(:start_date, :end_date, :semester_id)
    end

end