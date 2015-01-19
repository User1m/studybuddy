class CommentsController < ApplicationController
	
  before_action :confirm_logged_in

	def create
		@course = set_course
	    @comment = @course.comments.create(comment_params)
      flash[:notice] = "comment was successful"
	    redirect_to course_path(@course)
	end



	private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:course_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user, :title , :body, :created_at)
    end
end
