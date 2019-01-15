require "rails_helper"

RSpec.feature "Users can comment on ticketes" do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project) }
  let(:tickete) { FactoryBot.create(:tickete, project: project, author: user) }

  before do
    login_as(user)
    assign_role!(user, :manager, project)
  end

  scenario "with valid attributes" do
    visit project_tickete_path(project, tickete)
    fill_in "Text", with: "Added first comment"
    click_button "Create Comment"

    expect(page).to have_content "Comment has been created."
    within('#comments') do
      expect(page).to have_content "Added first comment"
    end
  end

  scenario "with invalid attributes" do
    visit project_tickete_path(project, tickete)
    click_button "Create Comment"

    expect(page).to have_content "Comment has not been created."
  end

  scenario "when changing a tickete's state" do
    FactoryBot.create(:state, name: "Open")
    visit project_tickete_path(project, tickete)
    fill_in "Text", with: "This is a big issue"
    select "Open", from: "State"
    click_button "Create Comment"

    expect(page).to have_content "Comment has been created."
    within('#tickete .state') do
      expect(page).to have_content "Open"
    end
  end
end