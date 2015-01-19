class SchedulesController < ApplicationController
  before_action :confirm_logged_in
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  # GET /schedules
  # GET /schedules.json
  def index
    @schedules = Schedule.all
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
    begin
      @schedule = Schedule.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid schedule #{params[:id]}"
      flash[:notice] = 'Invalid schedule'
      redirect_to store_url
    else
      respond_to do |format|
        format.html
        format.xml { render :xml => @schedule }
      end
    end
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
  end

  # GET /schedules/1/edit
  def edit
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)

    respond_to do |format|
      if @schedule.save
        flash[:notice] = 'Schedule was successfully created.'
        format.html { redirect_to @schedule }
        format.json { render action: 'show', status: :created, location: @schedule }
      else
        format.html { render action: 'new' }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedules/1
  # PATCH/PUT /schedules/1.json
  def update
    respond_to do |format|
      if @schedule.update(schedule_params)
        flash[:notice] = 'Schedule was successfully updated.'
        format.html { redirect_to @schedule}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule = current_schedule
    @schedule.destroy
    session[:schedule_id] = nil

    respond_to do |format|
      flash[:notice] = 'Your schedule has been cleared'
      format.html { redirect_to(:controller => "access",:action => 'index') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def schedule_params
      params[:schedule]
    end
  end
