class CourseGroupsController < ApplicationController
  before_action :set_course_group_and_subject, only: [:show, :edit, :update, :destroy]

  # GET /course_groups
  # GET /course_groups.json
  def index
    @course        = Subject.find(params[:subject_id])
    @course_groups = @course.course_groups
  end

  # GET /course_groups/1
  # GET /course_groups/1.json
  def show
  end

  # GET /course_groups/new
  def new
    @course_group = CourseGroup.new
  end

  # GET /course_groups/1/edit
  def edit
  end

  # POST /course_groups
  # POST /course_groups.json
  def create
    @course_group = CourseGroup.new(course_group_params)
    respond_to do |format|
      if @course_group.save
        format.html { redirect_to @course_group, notice: 'Course group was successfully created.' }
        format.json { render :show, status: :created, location: @course_group }
      else
        format.html { render :new }
        format.json { render json: @course_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_groups/1
  # PATCH/PUT /course_groups/1.json
  def update
    respond_to do |format|
      if @course_group.update(course_group_params)
        format.html { redirect_to @course_group, notice: 'Course group was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_group }
      else
        format.html { render :edit }
        format.json { render json: @course_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_groups/1
  # DELETE /course_groups/1.json
  def destroy
    @course_group.destroy
    respond_to do |format|
      format.html { redirect_to course_groups_url, notice: 'Course group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_group_and_subject
      @course_group = CourseGroup.find(params[:id])
      @course       = Subject.find(params[:subject_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_group_params
      params.require(:course_group).permit(:start_time, :end_time, :subject_id, :lecturer_id, :max_limit)
    end
end
