class CommentsController < ApplicationController
  before_action :set_tickete

  def create
    @comment = @tickete.comments.build(comment_params)
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
    params.require(:comment).permit(:text)
  end
end
