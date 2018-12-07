module ApplicationHelper
  def title(*parts) # * -> splat, array
    unless parts.empty?
      content_for :title do
        (parts << "Ticket").join(" - ")
      end
    end
  end
end
