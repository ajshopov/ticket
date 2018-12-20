require "rails_helper"

RSpec.feature "Users can create new tickets" do
  let(:user) { FactoryBot.create(:user) }
  before do
    login_as(user)
    project = FactoryBot.create(:project, name: "Internet Explorer")
    assign_role!(user, :viewer, project)

    visit project_path(project)
    click_link "New Tickete"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Non-standards compliance"
    fill_in "Description", with: "My pages are ugly!"
    click_button "Create Tickete"

    expect(page).to have_content "Tickete has been created."
    within("#tickete") do
      expect(page).to have_content "Author: #{user.email}"
    end
  end

  scenario "when providing invalid attributes" do
    click_button "Create Tickete"

    expect(page).to have_content "Tickete has not been created."
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Description can't be blank"
  end

  scenario "with an invalid decription length" do
    fill_in "Name", with: "Non-standards compliance"
    fill_in "Description", with: "No good"
    click_button "Create Tickete"

    expect(page).to have_content "Tickete has not been created."
    expect(page).to have_content "Description is too short"
  end
end