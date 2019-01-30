require 'rails_helper'

RSpec.feature "Users can receive notifications about tickete updates" do
  let(:allan) { FactoryBot.create(:user, email: "allan@example.com") }
  let(:bob) { FactoryBot.create(:user, email: "bob@example.com") }
  let(:project) { FactoryBot.create(:project) }
  let(:tickete) do
    FactoryBot.create(:tickete, project: project, author: allan)
  end

  before do
    assign_role!(allan, :manager, project)
    assign_role!(bob, :manager, project)

    login_as(bob)
    visit project_tickete_path(project, tickete)
  end

  # scenario "tickete authors automatically receive notifications" do
  #   fill_in "Text", with: "Is it out yet?"
  #   click_button "Create Comment"

  #   email = find_email!(allan.email)
  #   expected_subject = "[ticket] #{project.name} - #{tickete.name}"
  #   expect(email.subject).to eq expected_subject

  #   click_first_link_in_email(email)
  #   expect(current_path).to eq project_tickete_path(project, tickete)
  # end
end