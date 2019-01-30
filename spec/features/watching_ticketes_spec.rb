require 'rails_helper'

RSpec.feature "Users can watch and unwatch ticketes" do
  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project) }
  let(:tickete) do
    FactoryBot.create(:tickete, project: project, author: user)
  end

  before do
    assign_role!(user, "viewer", project)
    login_as(user)
    visit project_tickete_path(project, tickete)
  end

  scenario "successfully" do
    within("#watchers") do
      expect(page).to have_content user.email
    end

    click_link "Unwatch"
    expect(page).to have_content "You are no longer watching this tickete."

    within("#watchers") do
      expect(page).to_not have_content user.email
    end

    click_link "Watch"
    expect(page).to have_content "You are now watching this tickete."

    within("#watchers") do
      expect(page).to have_content user.email
    end
  end
end