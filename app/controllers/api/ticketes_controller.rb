class API::TicketesController < ApplicationController
  attr_reader :current_user

  before_action :authenticate_user
  before_action :set_project

  def show
    @tickete = @project.ticketes.find(params[:id])
    authorize @tickete, :show?
    render json: @tickete
  end

  private

  def authenticate_user
    authenticate_with_http_token do |token|
      @current_user = User.find_by(api_key: token)
    end
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end