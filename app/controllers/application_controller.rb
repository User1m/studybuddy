class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private

    def current_schedule
      Schedule.find(session[:schedule_id])
    rescue ActiveRecord::RecordNotFound
      schedule = Schedule.create
      session[:schedule_id] = schedule.id
      schedule
    end

    def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = ""
      redirect_to(:controller => "access", :action => 'login')
      return false
    else
      return true
    end
  end
  
end
