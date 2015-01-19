class StoreController < ApplicationController
  before_action :confirm_logged_in
  def index
    @courses = Course.all
  end
end
