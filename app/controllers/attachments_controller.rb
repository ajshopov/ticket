class AttachmentsController < ApplicationController
  skip_after_action :verify_authorized, only: [:new]

  def show
    attachment = Attachment.find(params[:id])
    authorize attachment, :show?
    send_file attachment.file.path, disposition: :inline # disposition default is download
  end

  def new
    @index = params[:index].to_i
    @tickete = Tickete.new
    @tickete.attachments.build
    render layout: false
  end
end
