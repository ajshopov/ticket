class TicketesController < ApplicationController
  before_action :set_project
  before_action :set_tickete, only: [:show, :edit, :update, :destroy]

  def new
    @tickete = @project.ticketes.build
  end

  def create
    @tickete = @project.ticketes.build(tickete_params)

    if @tickete.save
      flash[:notice] = "Tickete has been created."
      redirect_to [@project, @tickete]
    else
      flash.now[:alert] = "Tickete has not been created."
      render "new"
    end
  end

  def show
  end

  private

  def tickete_params
    params.require(:tickete).permit(:name, :description)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_tickete
    @tickete = @project.ticketes.find(params[:id])
  end
end