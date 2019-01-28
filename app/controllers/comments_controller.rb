class CommentsController < ApplicationController
  before_action :set_tickete

  def create
    whitelisted_params = comment_params

    unless policy(@tickete).change_state?
      whitelisted_params.delete(:state_id)
    end

    @comment = @tickete.comments.build(whitelisted_params)
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
end
