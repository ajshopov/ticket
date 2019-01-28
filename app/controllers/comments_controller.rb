class CommentsController < ApplicationController
  before_action :set_tickete

  def create
    @comment = @tickete.comments.build(sanitized_parameters)
    @comment.author = current_user
    authorize @comment, :create?

    if @comment.save
      flash[:notice] = "Comment has been created."
      redirect_to [@tickete.project, @tickete]
    else
      flash.now[:alert] = "Comment has not been created."
      @project = @tickete.project
      render "ticketes/show"
    end
  end

  private

  def set_tickete
    @tickete = Tickete.find(params[:tickete_id])
  end

  def comment_params
    params.require(:comment).permit(:text, :state_id, :tag_names)
  end

  def sanitized_parameters
    whitelisted_params = comment_params

    unless policy(@tickete).change_state?
      whitelisted_params.delete(:state_id)
    end

    unless policy(@tickete).tag?
      whitelisted_params.delete(:tag_names)
    end

    whitelisted_params
  end
end
