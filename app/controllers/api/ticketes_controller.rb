class API::TicketesController < API::ApplicationController
  before_action :set_project

  def show
    @tickete = @project.ticketes.find(params[:id])
    authorize @tickete, :show?
    render json: @tickete
  end

  def create
    @tickete = @project.ticketes.build(tickete_params)
    authorize @tickete, :create?
    if @tickete.save
      render json: @tickete, status: 201
    else
      render json: { errors: @tickete.errors.full_messages }, status: 422
    end
  end

  private

  def tickete_params
    params.require(:tickete).permit(:name, :description, :author_id)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end