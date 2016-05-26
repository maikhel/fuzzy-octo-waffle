class CourseGroupsController < ApplicationController
  before_action :set_course_group_and_subject, only: [:show, :edit, :update, :destroy, :registrate, :deregistrate, :update_grades]

  # GET /course_groups
  def index
    @subject       = Subject.find(params[:subject_id])
    @course_groups = @subject.course_groups
  end

  # GET /course_groups/overview
  def overview
    @course_groups = CourseGroup.all
  end


  # GET /course_groups/1
  def show
    @students = @course_group.users
  end

  # GET /course_groups/new
  def new
    @subject      = Subject.find(params[:subject_id])
    @course_group = CourseGroup.new
  end

  # GET /course_groups/1/edit
  def edit
  end

  def registrate
    if params[:user_ids]
      students = User.find params[:user_ids]
      CourseGroupJoiner.new(@course_group).enroll(students)
    else
      CourseGroupJoiner.new(@course_group).enroll(current_user)
    end
    redirect_to action: 'show', subject_id: params[:subject_id], id: params[:id]
  end

  def deregistrate
    if params[:user_ids]
      nil
    else
      CourseGroupJoiner.new(@course_group).leave(current_user)
    end
    redirect_to action: 'show', subject_id: params[:subject_id], id: params[:id]
  end

  def update_grades
    params[:grades].each do |grade_hash|
      grade = Grade.find_or_initialize_by(course_group_id: @course_group.id, user_id: grade_hash["user_id"])
      if grade.value.to_s != grade_hash["value"]
        grade.update(value: grade_hash["value"])
        GradeChangedMailer.notify(grade.id).deliver_later
      end
    end
    redirect_to subject_course_group_path(subject_id: @course_group.subject.id, id: @course_group.id)
  end

  # POST /course_groups
  # POST /course_groups.json
  def create
    @course_group = CourseGroup.new(course_group_params)
    respond_to do |format|
      if @course_group.save
        format.html { redirect_to subject_course_group_path(subject: @course_group.subject, id: @course_group.id) }
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
        format.html { redirect_to subject_course_groups_path(@subject.id) }
        # format.json { render :show, status: :ok, location: @course_group }
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
      format.html { redirect_to subject_course_groups_path(@subject.id) }
      # format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_group_and_subject
      @course_group = CourseGroup.find(params[:id])
      @subject      = Subject.find(params[:subject_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_group_params
      params.require(:course_group).permit(:start_time, :end_time, :weekday, :subject_id, :lecturer_id, :max_limit, :group_type)
    end
end
