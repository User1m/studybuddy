class LineItemsController < ApplicationController
  before_action :confirm_logged_in
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # POST /line_items
  # POST /line_items.json
  def create
    @schedule = current_schedule
    course = Course.find(params[:course_id])
    @line_item = @schedule.add_course(course.id)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to(@line_item.schedule) }
        format.json { render action: 'show', status: :created, location: @line_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /line_items/1/edit
  def edit
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        flash[:notice] = 'Line item was successfully updated.'
        format.html { redirect_to @line_item }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
#<%= link_to("My Schedule", :controller => 'schedules', :action => 'show', :id => session[:user_id]) %>
      format.html { redirect_to access_index_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:course_id, :schedule_id)
    end
  end
