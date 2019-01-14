class TicketesController < ApplicationController
  before_action :set_project
  before_action :set_tickete, only: [:show, :edit, :update, :destroy]

  def new
    @tickete = @project.ticketes.build
    authorize @tickete, :create?
    @tickete.attachments.build
  end

  def create
    @tickete = @project.ticketes.build(tickete_params)
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
    params.require(:tickete).permit(:name, :description, attachments_attributes: [:file, :file_cache])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_tickete
    @tickete = @project.ticketes.find(params[:id])
  end
end