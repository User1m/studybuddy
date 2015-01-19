class SessionsController < ApplicationController
   def create
    if user = User.authenticate(params[:name], params[:password])
      session[:user_id] = user.id
      redirect_to schedule_url#will need to each specific user
    else
      flash[:error] = "Invalid user/password combination"
      redirect_to login_url
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:error] = "Logged out"
    redirect_to users_url
  end
end
