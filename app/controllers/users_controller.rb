class UsersController < ApplicationController

before_action :set_user, only: [:show, :edit, :update, :update_password, :destroy]

  # GET /users
  # GET /users.json
  def index
    authorize User
    @users = User.paginate(:page => params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    authorize @user
  end

  # GET /users/new
  def new
    authorize User
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    authorize @user
  end

  def edit_account
    @user = current_user

    render 'edit'
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    authorize @user

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_path(@user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    # authorize @user

    respond_to do |format|
      if @user.update(user_params)
        next_url = current_user.admin? ? users_path : edit_account_path
        format.html { redirect_to next_url, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        next_action = current_user.admin? ? :edit : :edit_account
        format.html { render next_action }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

   def update_password
    respond_to do |format|
      if @user.update(user_params)
        format.html do
          sign_in @user, :bypass => true
          redirect_to user_path(@user), notice: 'User was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def my_study
    @user = current_user
    groups_ids = @user.course_groups.pluck(:id)
    @semesters = @user.semesters
    start_date = params[:start_date] || Date.today
    starting = start_date.to_date.beginning_of_week
    ending = starting.end_of_week
    @calendar_events = CalendarEvent.where(course_group: groups_ids).where('start_date BETWEEN ? AND ?', starting.beginning_of_day, ending.end_of_day).group_by {|d| d.start_date.to_date}
  end


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    authorize @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :street, :postal_code, :city, :country, :bank_account, :role, :index_num)
    end


end
