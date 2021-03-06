require "rails_helper"

RSpec.feature "Users can only see the appropriate links" do
  let(:project) { FactoryBot.create(:project) }
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:tickete) do
    FactoryBot.create(:tickete, project: project, author: user)
  end

  context "anonymous users" do
    scenario "cannot see the New Project link" do
      visit "/"
      expect(page).to_not have_link "New Project"
    end
  end
  
  context "non-admin users (project viewers)" do
    before do
      login_as(user)
      assign_role!(user, :viewer, project)
    end

    scenario "cannot see the New Project link" do
      visit "/"
      expect(page).to_not have_link "New Project"
    end

    scenario "cannot see the Delete Project link" do
      visit project_path(project)
      expect(page).to_not have_link "Delete Project"
    end

    scenario "cannot see the Edit Project link" do
      visit project_path(project)
      expect(page).to_not have_link "Edit Project"
    end

    scenario "cannot see the new tickete link" do
      visit project_path(project)
      expect(page).not_to have_link "New Tickete"
    end

    scenario "cannot see the Edit Tickete link" do
      visit project_tickete_path(project, tickete)
      expect(page).not_to have_link "Edit Tickete"
    end

    scenario "cannot see the Delete Tickete link" do
      visit project_tickete_path(project, tickete)
      expect(page).not_to have_link "Delete Tickete"
    end

    scenario "cannot see the New Comment form" do
      visit project_tickete_path(project, tickete)
      expect(page).not_to have_heading "New Comment"
    end
  end

  context "admin users" do
    before { login_as(admin) }

    scenario "can see the New Project link" do
      visit "/"
      expect(page).to have_link "New Project"
    end

    scenario "can see the Delete Project link" do
      visit project_path(project)
      expect(page).to have_link "Delete Project"
    end

    scenario "can see the Edit Project link" do
      visit project_path(project)
      expect(page).to have_link "Edit Project"
    end

    scenario "can see the new tickete link" do
      visit project_path(project)
      expect(page).to have_link "New Tickete"
    end

    scenario "can see the Edit Tickete link" do
      visit project_tickete_path(project, tickete)
      expect(page).to have_link "Edit Tickete"
    end

    scenario "can see the Delete Tickete link" do
      visit project_tickete_path(project, tickete)
      expect(page).to have_link "Delete Tickete"
    end

    scenario "can see the New Comment form" do
      visit project_tickete_path(project, tickete)
      expect(page).to have_heading "New Comment"
    end
  end
end