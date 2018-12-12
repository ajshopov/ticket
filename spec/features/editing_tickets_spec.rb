require "rails_helper"

RSpec.feature "Users can edit existing tickets" do
  let(:project) { FactoryGirl.create(:project) }
  let(:tickete) { FactoryGirl.create(:tickete, project: project) }

  before do
    visit project_tickete_path(project, tickete)
    click_link "Edit Tickete"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Make it really shiny"
    click_button "Update Tickete"

    expect(page).to have_content "Tickete has been updated."
    
    within("#tickete h2") do
      expect(page).to have_content "Make it really shiny"
      expect(page).not_to have_content tickete.name
    end
  end

  scenario "with invalid attributes" do
    fill_in "Name", with: ""
    click_button "Update Tickete"

    expect(page).to have_content "Tickete has not been updated."
  end
end