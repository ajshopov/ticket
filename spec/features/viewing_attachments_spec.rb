require 'rails_helper'

RSpec.feature "Users can view a tickete's attached files" do
  let(:user) { FactoryBot.create :user }
  let(:project) { FactoryBot.create :project }
  let(:tickete) { FactoryBot.create :tickete, project: project, author: user }
  let!(:attachment) { FactoryBot.create :attachment, tickete: tickete,
    file_to_attach: "spec/fixtures/speed.txt" }

  before do
    assign_role!(user, :viewer, project)
    login_as(user)
  end

  scenario "successfully" do
    visit project_tickete_path(project, tickete)
    click_link "speed.txt"

    expect(current_path).to eq attachment_path(attachment)
    expect(page).to have_content "This file is used in Chapter 9 to test the file upload ability."
  end
end