require 'rails_helper'

RSpec.describe TicketesController, type: :controller do
  let(:project) { FactoryBot.create(:project) }
  let(:user) { FactoryBot.create(:user) }

  before :each do
    assign_role!(user, :editor, project)
    sign_in user
  end

  it "can create ticketes, but not tag them" do
    post :create, params: { tickete: { name: "New ticket!",
                                      description: "Brand spankin' new",
                                      tag_names: "these are tags" },
                          project_id: project.id }
    expect(Tickete.last.tags).to be_empty
  end
end
