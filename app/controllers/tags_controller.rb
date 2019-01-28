class TagsController < ApplicationController
  def remove
    @tickete = Tickete.find(params[:tickete_id])
    @tag = Tag.find(params[:id])
    authorize @tickete, :tag?

    @tickete.tags.destroy(@tag)
    head :ok
  end
end
