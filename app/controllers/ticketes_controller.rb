class TicketesController < ApplicationController
  before_action :set_project
  before_action :set_tickete, only: [:show, :edit, :update, :destroy, :watch]

  def search
    authorize @project, :show?
    # if params[:search].present?
    #   @ticketes = @project.ticketes.where(id: "#{params[:search]}%")
    # else
    #   @ticketes = @project.ticketes
    # end
    render "projects/show"
  end

  def watch
    authorize @tickete, :show?
    if @tickete.watchers.exists?(current_user.id)
      @tickete.watchers.destroy(current_user)
      flash[:notice] = "You are no longer watching this tickete."
    else
      @tickete.watchers << current_user
      flash[:notice] = "You are now watching this tickete."
    end
    redirect_to project_tickete_path(@tickete.project, @tickete)
  end

  def new
    @tickete = @project.ticketes.build
    authorize @tickete, :create?
    @tickete.attachments.build
  end

  def create
    @tickete = @project.ticketes.new
    whitelisted_params = tickete_params
    unless policy(@tickete).tag?
      whitelisted_params.delete(:tag_names)
    end

    @tickete.attributes = whitelisted_params
    @tickete.author = current_user
    authorize @tickete, :create?

    if @tickete.save
      flash[:notice] = "Tickete has been created."
      redirect_to [@project, @tickete]
    else
      flash.now[:alert] = "Tickete has not been created."
      render "new"
    end
  end

  def show
    authorize @tickete, :show?
    @comment = @tickete.comments.build(state_id: @tickete.state_id)

    respond_to do |format|
      format.html
      format.json { render json: @tickete}
    end
  end

  def edit
    authorize @tickete, :update?
  end

  def update
    authorize @tickete, :update?

    if @tickete.update(tickete_params)
      flash[:notice] = "Tickete has been updated."
      redirect_to [@project, @tickete]
    else
      flash.now[:alert] = "Tickete has not been updated."
      render "edit"
    end
  end

  def destroy
    authorize @tickete, :destroy?

    @tickete.destroy
    flash[:notice] = "Tickete has been deleted."

    redirect_to @project
  end

  private

  def tickete_params
    params.require(:tickete).permit(:name, :description, :tag_names, attachments_attributes: [:file, :file_cache])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_tickete
    @tickete = @project.ticketes.find(params[:id])
  end
end