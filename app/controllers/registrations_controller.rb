class RegistrationsController < ApplicationController

  before_action :set_registration, only: [:show, :edit]

  def index
    @registrations = Registration.all
    @course_groups = CourseGroup.all
  end

  def new
    @registration = Registration.new
  end

  def edit
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registration
      @registration = Registration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:registration).permit(:start_date, :end_date, :field_of_study_id)
    end

end